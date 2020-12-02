class ConstanciaDocumentosController < ApplicationController
  before_action :authenticate_user!, except: [:show, :imprimir]
  before_action :set_constancia_documento, only: [:show, :edit, :update, :destroy]

  # GET /constancia_documentos
  # GET /constancia_documentos.json

  # Se muestran las conctancias al director unicamente sino están firmadas
  #"firma_direccion = ? AND constancia_emitida = ?", nil , true
  def index
    if current_user.role.nombre == "Dirección"
      @filterrific = initialize_filterrific(
        ConstanciaDocumento.where(firma_direccion: nil, constancia_emitida: true).order('numero_oficio DESC'),
        params[:filterrific],
        select_options: {
          unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
          numero_relacion: ConstanciaDocumento.options_for_numero_relacion
        },
        sanitize_params: true,
      ) || return
    else
      @filterrific = initialize_filterrific(
        ConstanciaDocumento.order('created_at DESC'),
        params[:filterrific],
        select_options: {
          unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
          numero_relacion: ConstanciaDocumento.options_for_numero_relacion
        },
        sanitize_params: true,
      ) || return
    end

    @constancia_documentos = @filterrific.find.page(params[:pagina])

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end

    # Recover from invalid param sets, e.g., when a filter refers to the
    # database id of a record that doesn’t exist any more.
    # In this case we reset filterrific and discard all filter params.
    rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Se reasignaron parámetros de filterrific: #{e.message}"
    redirect_to(reset_filterrific_url(format: :html)) && return
  end

  def validar_constancias
    @filterrific = initialize_filterrific(
      ConstanciaDocumento.where(constancia_emitida: false).order('numero_oficio DESC'),
      params[:filterrific],
      select_options: {
        unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
        numero_relacion: ConstanciaDocumento.options_for_numero_relacion
      },
      sanitize_params: true,
    ) || return

    @constancia_documentos = @filterrific.find.page(params[:pagina])

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end

    # Recover from invalid param sets, e.g., when a filter refers to the
    # database id of a record that doesn’t exist any more.
    # In this case we reset filterrific and discard all filter params.
    rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Se reasignaron parámetros de filterrific: #{e.message}"
    redirect_to(reset_filterrific_url(format: :html)) && return
  end

  def get_info_alumno
    require 'net/http'
    require 'json'
    require 'uri'
    @boleta = params[:q]

    uri = URI.parse("https://dae.ipn.mx/ws_deyss/inscritosjson?boleta="+@boleta)
    response = Net::HTTP.get_response(uri)
    if response.code == "200"
       result = JSON.parse(response.body)
    end
    render json: result
  end

  def get_info_curp
    require 'net/http'
    require 'uri'
    require 'openssl'
    require 'json'

    uri = URI.parse("https://api.cenac.ipn.mx/gw/token")
    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "Basic bDR2cGFfa0Vka3hSX0NiMzRJMERUd2gyeHhvYTptZzFnaXUzV0xOU290RjBZQ1F6ZnF0ZnNkNXNh"
    request.set_form_data(
      "grant_type" => "password",
      "password" => "5HHh8PVfX7VencqA",
      "username" => "s_dess",

    )
    req_options = {
      use_ssl: uri.scheme == "https",
      verify_mode: OpenSSL::SSL::VERIFY_NONE,
    }
    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    hash_response = JSON.parse(response.body)
    @token_ws = hash_response['access_token']
    puts @token_ws


    uri = URI.parse("https://api.cenac.ipn.mx/gw/renapo/1.0.0/curp/consultar")
    request = Net::HTTP::Post.new(uri)
    request.content_type = "application/json"
    request["Accept"] = "application/json"
    request["Authorization"] = "Bearer "+@token_ws
    request.body = JSON.dump({
      "data" => {
        "curp" => params[:q]
      }
    })

    req_options = {
      use_ssl: uri.scheme == "https",
      verify_mode: OpenSSL::SSL::VERIFY_NONE,
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    # response.code
    # response.body
    hash_response = JSON.parse(response.body)
    render json: hash_response

    # response.code
    # response.body
  end

  # GET /constancia_documentos/1
  # GET /constancia_documentos/1.json
  def show
  end

  # GET /constancia_documentos/new
  def new
    @constancia_documento = current_user.constancia_documentos.build
    authorize @constancia_documento
  end

  # GET /constancia_documentos/1/edit
  def edit
    authorize @constancia_documento
  end

  # POST /constancia_documentos
  # POST /constancia_documentos.json
  def create
    @constancia_documento = current_user.constancia_documentos.build(constancia_documento_params)

    respond_to do |format|
      if @constancia_documento.save
        if current_user.role.nombre == "Captura"
          format.html { redirect_to constancia_documentos_path, notice: 'La constancia fue creada correctamente.' }
        else
          format.html { redirect_to @constancia_documento, notice: 'La constancia fue creada correctamente.' }
          format.json { render :show, status: :created, location: @constancia_documento }
        end
      else
        format.html { render :new }
        format.json { render json: @constancia_documento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /constancia_documentos/1
  # PATCH/PUT /constancia_documentos/1.json
  def update
    @constancia_documento.firma_direccion = nil
    respond_to do |format|
      if @constancia_documento.update(constancia_documento_params)
        format.html { redirect_to @constancia_documento, notice: 'La constancia fue actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @constancia_documento }
      else
        format.html { render :edit }
        format.json { render json: @constancia_documento.errors, status: :unprocessable_entity }
      end
    end
    authorize @constancia_documento
  end

  # DELETE /constancia_documentos/1
  # DELETE /constancia_documentos/1.json
  def destroy
    @constancia_documento.destroy
    respond_to do |format|
      format.html { redirect_to constancia_documentos_url, notice: 'La constancia fue eliminada correctamente.' }
      format.json { head :no_content }
    end
  end

  def firmar
    @constancia_documentos = ConstanciaDocumento.formar_cadena(params[:constancia_documento_ids])
  end

  def validar
    @constancia_documentos = ConstanciaDocumento.validar_constancias(params[:constancia_documento_ids])
    redirect_to validar_constancias_constancia_documentos_path, notice: 'La(s) constancia(s) ha(n) sido validada(s) correctamente.'
  end

  def actualizar_firma
    ConstanciaDocumento.actualizar_firma(params[:firmaElectronica])
    redirect_to constancia_documentos_path, notice: 'La(s) constancia(s) ha(n) sido firmada(s) correctamente.'
  end

  def imprimir
    @constancia_documento = ConstanciaDocumento.find_by uuid: params[:uuid]
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "Constancia_" + @constancia_documento.boleta,   # Excluding ".pdf" extension.
        template: "constancia_documentos/imprimir.html.erb",
        layout: "imprimir.html.erb"
      end
    end
  end

  def imprimir_relacion
    @constancia_documentos = ConstanciaDocumento.generar_lista(params[:relacion], params[:escuela], params[:anio])
    @relacion = params[:relacion]
    @unidad_academica = @constancia_documentos.pluck(:unidad_academica).first
    @anio = params[:anio]
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "RELACION_" + @relacion + "_" + @unidad_academica + "_"+ @anio,
        footer: { right: 'Página [page] de [topage]', font_size: 10, },
        template: "constancia_documentos/imprimir_relacion.html.erb",
        layout: "imprimir_relacion.html.erb",
        orientation: "Landscape"
      end
    end
  end

  def consultar_datos
    @respuesta = ConstanciaDocumento.consultar_ws_dae(params[:boleta])
  end

  def buscar_relacion
  end

  def relacion
    if params[:relacion] && params[:escuela] && params[:anio]
      @constancia_documentos = obtener_relacion
      @relacion = params[:relacion]
      @unidad_academica = @constancia_documentos.pluck(:unidad_academica).first
      @anio = params[:anio]
    else
      redirect_to buscar_relacion_constancia_documentos_path, notice: 'Debe de introducir una CURP válida.'
    end
  end

  def obtener_relacion
    @constancia_documentos = ConstanciaDocumento.generar_lista(params[:relacion], params[:escuela], params[:anio])
  end

  def constancias_firmadas
    @filterrific = initialize_filterrific(
      ConstanciaDocumento.where.not(firma_direccion: nil).order('numero_oficio DESC'),
      params[:filterrific],
      select_options: {
        unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
        numero_relacion: ConstanciaDocumento.options_for_numero_relacion
      },
      sanitize_params: true,
    ) || return

    @constancia_documentos = @filterrific.find.page(params[:pagina])

    # Respond to html for initial page load and to js for AJAX filter updates.
    respond_to do |format|
      format.html
      format.js
    end

    @numero_constancias = ConstanciaDocumento.where.not(firma_direccion: nil).count

    # Recover from invalid param sets, e.g., when a filter refers to the
    # database id of a record that doesn’t exist any more.
    # In this case we reset filterrific and discard all filter params.
    rescue ActiveRecord::RecordNotFound => e
    # There is an issue with the persisted param_set. Reset it.
    puts "Se reasignaron parámetros de filterrific: #{e.message}"
    redirect_to(reset_filterrific_url(format: :html)) && return
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_constancia_documento
      #@constancia_documento = ConstanciaDocumento.find(params[:id])
      @constancia_documento = ConstanciaDocumento.find_by uuid: params[:uuid]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def constancia_documento_params
      params.require(:constancia_documento).permit(:numero_relacion,
        :numero_oficio, :numero_registro, :codigo_prestatario, :clave_programa,
        :fecha, :nombre, :boleta, :unidad_academica, :programa_academico,
        :periodo, :prestatario, :constancia_emitida, :apellido_paterno,
        :apellido_materno, :correo, :user_id)
    end

    def constancia_documento
      @constancia_documento = ConstanciaDocumento.new(constancia_documento_params)
    end

    def firmar_constancia_params
     params.require(:constancia_documento).permit(:firma_direccion)
   end
end
