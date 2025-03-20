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
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ESCOM"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"ESCUELA SUPERIOR DE COMPUTO").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ESFM"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"ESCUELA SUPERIOR DE FISICA Y MATEMATICAS").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ESIATEC"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"ESCUELA SUPERIOR DE INGENIERIA Y ARQUITECTURA, UNIDAD TECAMACHALCO").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ESIATIC"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"ESCUELA SUPERIOR DE INGENIERIA Y ARQUITECTURA, UNIDAD TICOMAN").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ESIAZ"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"ESCUELA SUPERIOR DE INGENIERIA Y ARQUITECTURA, UNIDAD ZACATENCO").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ESIMEAZ"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"ESCUELA SUPERIOR DE INGENIERIA MECANICA Y ELECTRICA, UNIDAD AZCAPOTZALCO").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ESIMECUL"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"ESCUELA SUPERIOR DE INGENIERIA MECANICA Y ELECTRICA, UNIDAD CULHUACAN").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ESIMETIC"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"ESCUELA SUPERIOR DE INGENIERIA MECANICA Y ELECTRICA, UNIDAD TICOMAN").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ESIMEZ"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"ESCUELA SUPERIOR DE INGENIERIA MECANICA Y ELECTRICA, UNIDAD ZACATENCO").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ESIQIE"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"ESCUELA SUPERIOR DE INGENIERIA QUIMICA E INDUSTRIAS EXTRACTIVAS").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ESIT"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"ESCUELA SUPERIOR DE INGENIERIA TEXTIL").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ISISAAZ"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"RED ACADEMICA DE INGENIERIA EN SISTEMAS AUTOMOTRICES (ISISA) - ESIME AZCAPOTZALCO").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ISISACUL"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"RED ACADEMICA DE INGENIERIA EN SISTEMAS AUTOMOTRICES (ISISA) - ESIME CULHUACAN").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ISISAESC"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"RED ACADEMICA DE INGENIERIA EN SISTEMAS AUTOMOTRICES (ISISA) - ESCOM").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ISISATIC"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"RED ACADEMICA DE INGENIERIA EN SISTEMAS AUTOMOTRICES (ISISA) - ESIME TICOMAN").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ISISAUPIICSA"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"RED ACADEMICA DE INGENIERIA EN SISTEMAS AUTOMOTRICES (ISISA) - UPIICSA").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ISISAUPIIG"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"RED ACADEMICA DE INGENIERIA EN SISTEMAS AUTOMOTRICES (ISISA) - UPIIG").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ISISAUPIIH"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"RED ACADEMICA DE INGENIERIA EN SISTEMAS AUTOMOTRICES (ISISA) - UPIIH").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ISISAUPIITA"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"RED ACADEMICA DE INGENIERIA EN SISTEMAS AUTOMOTRICES (ISISA) - UPIITA").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ISISAZ"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"RED ACADEMICA DE INGENIERIA EN SISTEMAS AUTOMOTRICES (ISISA) - ESIME ZACATENCO").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "UPIIGTO"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"UNIDAD PROFESIONAL INTERDISCIPLINARIA DE INGENIERIA, CAMPUS GUANAJUATO").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "UPIIHDL"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"UNIDAD PROFESIONAL INTERDISCIPLINARIA DE INGENIERIA, CAMPUS HIDALGO").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "UPIIZAC"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"UNIDAD PROFESIONAL INTERDISCIPLINARIA DE INGENIERIA, CAMPUS ZACATECAS").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "UPIICOA"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"UNIDAD PROFESIONAL INTERDISCIPLINARIA DE INGENIERIA, CAMPUS COAHUILA").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "UPIITLA"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"UNIDAD PROFESIONAL INTERDISCIPLINARIA DE INGENIERIA, CAMPUS TLAXCALA").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "UPIIPAL"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"UNIDAD PROFESIONAL INTERDISCIPLINARIA DE INGENIERIA, CAMPUS PALENQUE").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "UPIICSA"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"UNIDAD PROFESIONAL INTERDISCIPLINARIA DE INGENIERIA Y CIENCIAS SOCIALES Y ADMINISTRATIVAS").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "UPIITA"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"UNIDAD PROFESIONAL INTERDISCIPLINARIA EN INGENIERIA Y TECNOLOGIAS AVANZADAS").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CICSUMA"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"CENTRO INTERDISCIPLINARIO DE CIENCIAS DE LA SALUD, UNIDAD MILPA ALTA").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CICSUST"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"CENTRO INTERDISCIPLINARIO DE CIENCIAS DE LA SALUD, UNIDAD SANTO TOMAS").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ENCB"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"ESCUELA NACIONAL DE CIENCIAS BIOLOGICAS").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ENMH"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"ESCUELA NACIONAL DE MEDICINA Y HOMEOPATIA").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ESEO"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"ESCUELA SUPERIOR DE ENFERMERIA Y OBSTETRICIA").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ESM"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"ESCUELA SUPERIOR DE MEDICINA").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ESCAUST"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"ESCUELA SUPERIOR DE COMERCIO Y ADMINISTRACION, UNIDAD SANTO TOMAS").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ESCATEP"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"ESCUELA SUPERIOR DE COMERCIO Y ADMINISTRACION, UNIDAD TEPEPAN").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ESE"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"ESCUELA SUPERIOR DE ECONOMIA").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "EST"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"ESCUELA SUPERIOR DE TURISMO").order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CECyT1"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 1 "GONZALO VAZQUEZ VELA"').order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CECyT2"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 2 "MIGUEL BERNARD PERALES"').order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CECyT3"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 3 "ESTANISLAO RAMIREZ RUIZ"').order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CECyT4"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 4 "LAZARO CARDENAS DEL RIO"').order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CECyT5"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 5 "BENITO JUAREZ GARCIA"').order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CECyT6"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 6 "MIGUEL OTHON DE MENDIZABAL"').order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CECyT7"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 7 "CUAUHTEMOC"').order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CECyT8"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 8 "NARCISO BASSOLS GARCIA"').order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CECyT9"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 9 "JUAN DE DIOS BATIZ PAREDES"'
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CECyT10"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 10 "CARLOS VALLEJO MARQUEZ"'
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CECyT11"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 11 "WILFRIDO MASSIEU PEREZ"'
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CECyT12"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 12 "JOSE MARIA MORELOS Y PAVON"'
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CECyT13"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 13 "RICARDO FLORES MAGON"'
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CECyT14"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 14 "LUIS ENRIQUE ERRO SOLER"'
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CECyT15"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 15 "DIODORO ANTUNEZ ECHEGARAY"'
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CECyT16"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 16 "HIDALGO"'
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CECyT17"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 17 "LEON GUANAJUATO"'
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CECyT18"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 18 "ZACATECAS"'
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CET1"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'CENTRO DE ESTUDIOS TECNOLOGICOS No. 1 "WALTER CROSS BUCHANAN"'
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CESMT"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"CENTRO DE ESTUDIOS SUPERIORES DE MARTINEZ DE LA TORRE, S.C."
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CETUG"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"CENTRO DE ESTUDIOS TECNOLOGICOS Y UNIVERSITARIOS DEL GOLFO"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CICIMAR"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"CENTRO INTERDISCIPLINARIO DE CIENCIAS MARINAS"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CLAES"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"CENTRO LATINOAMERICANO DE ESTUDIOS SUPERIORES"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CUD"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"CENTRO UNIVERSITARIO DORADOS"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CUGSCU"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"CENTRO UNIVERSITARIO GRUPO SOL, CAMPUS CUAUHTEMOC"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CUGSCE"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"CENTRO UNIVERSITARIO GRUPO SOL, CEM, S.C. PLANTEL SANTO TOMAS"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "CUGSCH"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"CENTRO UNIVERSITARIO GRUPO SOL, PLANTEL CHALCO"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "DIF"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"DIF DE ENFERMERIA, A.C.,"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "EBC"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"ESCUELA BANCARIA Y COMERCIAL"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ETZU"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"ESCUELA TECNOLOGICA DE ZUMPANGO, A.C."
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ILBC"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"INSTITUTO LEONARDO BRAVO, A.C."
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "IBPU"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"INSTITUTO BRITANICO DE LA CIUDAD DE PUEBLA"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "IESCA"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"INSTITUTO DE ENSEÑANZA SUPERIOR EN CONTADURIA Y ADMINISTRACION, S.C."
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "IESHDL"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'INSTITUTO DE ESTUDIOS SUPERIORES "HIDALGO"'
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ITSV"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"INSTITUTO DE TURISMO STUDIO VIAJES, A.C."
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "IESCAGJ"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'INSTITUTO ESPECIALIZADO EN COMPUTACION Y ADMINISTRACION "GAUSS JORDAN", A.C.'
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ILBRAZA"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"INSTITUTO LEONARDO BRAVO, A.C., PLANTEL LA RAZA"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ILBRAZA"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"INSTITUTO LEONARDO BRAVO, A.C., PLANTEL VERACRUZ"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "IMEPIZ"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"INSTITUTO MEXICANO DE EDUCACION PROFESIONAL, PLANTEL IZTAPALAPA"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "IMEPSTM"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"INSTITUTO MEXICANO DE EDUCACION PROFESIONAL, PLANTEL SANTA MARTHA"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ISECO"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"INSTITUTO SUPERIOR DE ESTUDIOS COMERCIALES"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ITPP"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"INSTITUTO TECNICO PROFESIONAL PANAMERICANO"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ITBSC"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:'INSTITUTO TECNICO Y BANCARIO, "SAN CARLOS"'
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ITESS"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"INSTITUTO TECNOLOGICO DE ESTUDIOS SUPERIORES DEL SURESTE, A.C."
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "UARKOS"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"UNIVERSIDAD ARKOS"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "UCELAYA"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"UNIVERSIDAD DE CELAYA"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "UFLP"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"UNIVERSIDAD FRAY LUCA PACCIOLI"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "ISECVALLE"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"UNIVERSIDAD ISEC, PLANTEL DEL VALLE"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "UPI"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"UNIVERSIDAD PRIVADA DE IRAPUATO"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "UTCMCELAYA"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"UNIVERSIDAD TECNOLOGICA DEL CENTRO DE MEXICO, CAMPUS CELAYA"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "UTSCAMPE"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"UNIVERSIDAD TECNOLOGICA DEL SURESTE, S.C., PLANTEL CAMPECHE"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "UTSCOATZ"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"UNIVERSIDAD TECNOLOGICA DEL SURESTE, S.C., PLANTEL COATZACOALCOS"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "UTI"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"UNIVERSIDAD TECNOLOGICA INTERNACIONAL"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "UTM"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"UNIVERSIDAD TECNOLOGICA MESOAMERICANA, S.C."
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "IMCN"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"INSTITUTO MEXICANO DE CERTIFICACIÓN Y NORMAS, S.C."
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "UPIBI"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"UNIDAD PROFESIONAL INTERDISCIPLINARIA DE BIOTECNOLOGIA"
          ).order('numero_oficio DESC'),
          params[:filterrific],
          select_options: {
            unidad_academica: ConstanciaDocumento.options_for_unidad_academica,
            numero_relacion: ConstanciaDocumento.options_for_numero_relacion
          },
          sanitize_params: true,
        ) || return
      elsif current_user.role.nombre == "Unidad Academica" && current_user.role.descripcion == "UPIEM"
        @filterrific = initialize_filterrific(
          ConstanciaDocumento.where(unidad_academica:"UNIDAD PROFESIONAL INTERDISCIPLINARIA DE ENERGIA Y MOVILIDAD"
          ).order('numero_oficio DESC'),
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
