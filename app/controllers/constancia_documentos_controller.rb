class ConstanciaDocumentosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_constancia_documento, only: [:show, :edit, :update, :destroy]

  # GET /constancia_documentos
  # GET /constancia_documentos.json
=begin
  def index
    if current_user.role.nombre == "Dirección"
      @constancia_documentos = ConstanciaDocumento.where(firma_direccion: nil)
    else
      @constancia_documentos = ConstanciaDocumento.all
    end
    authorize @constancia_documentos
  end
=end
  def index
    @filterrific = initialize_filterrific(
      ConstanciaDocumento,
      params[:filterrific],
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


  # GET /constancia_documentos/1
  # GET /constancia_documentos/1.json
  def show
  end

  # GET /constancia_documentos/new
  def new
    @constancia_documento = current_user.constancia_documentos.build
  end

  # GET /constancia_documentos/1/edit
  def edit
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
    respond_to do |format|
      if @constancia_documento.update(constancia_documento_params)
        format.html { redirect_to @constancia_documento, notice: 'La constancia fue actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @constancia_documento }
      else
        format.html { render :edit }
        format.json { render json: @constancia_documento.errors, status: :unprocessable_entity }
      end
    end
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
    public_key = OpenSSL::PKey::RSA.new(File.read(Rails.root.join('public.pem')))
    constancia_documentos = ConstanciaDocumento.find(params[:constancia_documento_ids])
    constancia_documentos.each do |constancia_documento|
      folio = constancia_documento.folio
      numero_relacion = constancia_documento.numero_relacion
      numero_oficio = constancia_documento.numero_oficio
      numero_registro = constancia_documento.numero_registro
      codigo_prestatario = constancia_documento.codigo_prestatario
      clave_programa = constancia_documento.clave_programa
      fecha = constancia_documento.fecha
      nombre = constancia_documento.nombre
      boleta = constancia_documento.boleta
      unidad_academica = constancia_documento.unidad_academica
      programa_academico = constancia_documento.programa_academico
      periodo = constancia_documento.periodo
      prestatario = constancia_documento.prestatario
      cadena = folio + '|' + numero_relacion + '|' + numero_oficio + '|' +
      numero_registro + '|' + codigo_prestatario + '|' + clave_programa + '|' +
      fecha + '|' + nombre + '|' + boleta + '|' + unidad_academica + '|' + programa_academico
      firma = public_key.public_encrypt(cadena)
      firma_electronica = Base64.encode64(firma)
      constancia_documento.update(firma_direccion: firma_electronica)
=begin
  #Para el descifrado
  private_key = OpenSSL::PKey::RSA.new(File.read(Rails.root.join('private.pem')))
  reg = @constancia_documento
  info = reg.firma_direccion.gsub("\n","")
  infobin = Base64.decode64(info)
  private_key.private_decrypt(infobin)
=end
    end
    redirect_to constancia_documentos_path, notice: 'La(s) constancia(s) ha(n) sido firmada(s) correctamente.'
  end

  def imprimir
    @constancia_documento = ConstanciaDocumento.find_by uuid: params[:uuid]
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "file_name",   # Excluding ".pdf" extension.
        template: "constancia_documentos/imprimir.html.erb",
        layout: "imprimir.html.erb"
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_constancia_documento
      #@constancia_documento = ConstanciaDocumento.find(params[:id])
      @constancia_documento = ConstanciaDocumento.find_by uuid: params[:uuid]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def constancia_documento_params
      params.require(:constancia_documento).permit(:folio, :numero_relacion,
        :numero_oficio, :numero_registro, :codigo_prestatario, :clave_programa,
        :fecha, :nombre, :boleta, :unidad_academica, :programa_academico,
        :periodo, :prestatario, :constancia_emitida, :apellido_paterno,
        :apellido_materno, :user_id)
    end

    def constancia_documento
      @constancia_documento = ConstanciaDocumento.new(constancia_documento_params)
    end

    def firmar_constancia_params
     params.require(:constancia_documento).permit(:firma_direccion)
   end
end
