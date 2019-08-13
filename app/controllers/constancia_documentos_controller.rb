class ConstanciaDocumentosController < ApplicationController
  before_action :set_constancia_documento, only: [:show, :edit, :update, :destroy]

  # GET /constancia_documentos
  # GET /constancia_documentos.json
  def index
    @constancia_documentos = ConstanciaDocumento.all
  end

  # GET /constancia_documentos/1
  # GET /constancia_documentos/1.json
  def show
  end

  # GET /constancia_documentos/new
  def new
    @constancia_documento = ConstanciaDocumento.new
  end

  # GET /constancia_documentos/1/edit
  def edit
  end

  # POST /constancia_documentos
  # POST /constancia_documentos.json
  def create
    @constancia_documento = ConstanciaDocumento.new(constancia_documento_params)

    respond_to do |format|
      if @constancia_documento.save
        format.html { redirect_to @constancia_documento, notice: 'Constancia documento was successfully created.' }
        format.json { render :show, status: :created, location: @constancia_documento }
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
        format.html { redirect_to @constancia_documento, notice: 'Constancia documento was successfully updated.' }
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
      format.html { redirect_to constancia_documentos_url, notice: 'Constancia documento was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_constancia_documento
      @constancia_documento = ConstanciaDocumento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def constancia_documento_params
      params.require(:constancia_documento).permit(:folio, :numero_relacion, :numero_oficio, :numero_registro, :codigo_prestatario, :clave_programa, :fecha, :nombre, :boleta, :unidad_academica, :programa_academico, :periodo, :prestatario, :constancia_emitida)
    end
end
