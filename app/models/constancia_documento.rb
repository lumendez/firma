class ConstanciaDocumento < ApplicationRecord
  uuidable

  validates :numero_oficio, :numero_registro,
  :fecha, :nombre, :boleta, :unidad_academica, :programa_academico,
  :user_id, presence: true

  filterrific(
    available_filters: [
      :search_query,
      :unidad_academica,
      :numero_relacion
    ],
  )

  paginates_per 40

  belongs_to :user

  # before_save sólo funciona después de que la validación haya pasado
  # correctamente
  before_save :asignar_emision

  def asignar_emision
      self.constancia_emitida = false if self.constancia_emitida.nil?
  end

  scope :search_query, lambda { |query|

    # Filtra a los usuarios por nombre o apellido paterno
    return nil  if query.blank?

    # Condiciones del query divididas en palabras separadas y en minúsculas
    terms = query.to_s.downcase.split(/\s+/)

    # Reemplaza "*" con "%" para búsquedas con comodin,
    # liga '%', quita los '%' duplicados
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }

    # Configura el numero de condiciones OR proporcionados (provision)
    # como argumentos de interpolaciOn. Ajustar si se cambian el
    # número de condiciones OR.
    num_or_conds = 1

    where(
      terms.map { |term|
        "(constancia_documentos.boleta LIKE ?)"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conds }.flatten
    )
  }

  def to_param
    uuid
  end

  def nombre_completo
    "#{nombre} #{apellido_paterno} #{apellido_materno}"
  end

  def self.formar_cadena(constancia_documento_ids)
    constancia_documentos = ConstanciaDocumento.find(constancia_documento_ids)
    cadenas = []
    constancia_documentos.each do |constancia_documento|
      numero_relacion = constancia_documento.numero_relacion
      numero_oficio = constancia_documento.numero_oficio
      numero_registro = constancia_documento.numero_registro
      codigo_prestatario = constancia_documento.codigo_prestatario
      clave_programa = constancia_documento.clave_programa
      fecha = constancia_documento.fecha
      nombre = constancia_documento.nombre
      paterno = constancia_documento.apellido_paterno
      materno = constancia_documento.apellido_materno
      boleta = constancia_documento.boleta
      unidad_academica = constancia_documento.unidad_academica
      programa_academico = constancia_documento.programa_academico
      periodo = constancia_documento.periodo
      prestatario = constancia_documento.prestatario
      creado = constancia_documento.created_at.to_s
      uuid = constancia_documento.uuid
      cadena = '||' + numero_relacion + '|' + numero_oficio + '|' +
      numero_registro + '|' + codigo_prestatario + '|' + clave_programa + '|' +
      fecha + '|' + nombre + '|' + paterno + '|' + materno + '|' + boleta + '|' +
      unidad_academica + '|' + programa_academico + '|' + creado + '|' + uuid +'||'
      constancia_documento.update_attributes(firma_departamento: cadena)
      objetos = Hash.new
      objetos["cadena"] = cadena
      objetos["id"] = constancia_documento.id
      cadenas << objetos
    end
    cadenas.to_json
  end

  def self.actualizar_firma(firma_electronica)
    hash_firma = eval(firma_electronica)
    hash_firma[:data][:cadena].each do |x|
      constancia = ConstanciaDocumento.find("#{x[:id]}")
      constancia.update_attributes(firma_direccion: "#{x[:firma]}")
      #if constancia.correo.present?
        #UserMailer.email_notificacion(constancia).deliver unless constancia.invalid?
      #end
    end
  end

  def self.validar_constancias(constancia_documento_ids)
    constancia_documentos = ConstanciaDocumento.find(constancia_documento_ids)
    constancia_documentos.each do |constancia_documento|
      constancia_documento.update_attributes(constancia_emitida: true)
    end
  end

  def self.generar_lista(relacion, escuela, anio)
    # Usar la siguiente expresion para generar la busqueda en SQLite
    #constancia_documentos = ConstanciaDocumento.where("numero_relacion = ? AND unidad_academica = ? AND cast(strftime('%Y', created_at) as int) = ?", relacion, escuela, anio)
    # Usar la siguiente expresion para generar la busqueda en MySQL
    constancia_documentos = ConstanciaDocumento.where("numero_relacion = ? AND unidad_academica = ? AND extract(year from created_at) = ?", relacion, escuela, anio)
  end

  def nombre_completo
    "#{nombre} #{apellido_paterno} #{apellido_materno}"
  end

  scope :unidad_academica, lambda { |unidad_academica|
    where(unidad_academica: [*unidad_academica])
  }

  scope :numero_relacion, lambda { |numero_relacion|
    where(numero_relacion: [*numero_relacion])
  }

  def self.options_for_unidad_academica
    [
      ['ESCOM',	'ESCUELA SUPERIOR DE COMPUTO'],
      ['ESFM', 'ESCUELA SUPERIOR DE FISICA Y MATEMATICAS'], 
      ['ESIA TECAMACHALCO',	'ESCUELA SUPERIOR DE INGENIERIA Y ARQUITECTURA, UNIDAD TECAMACHALCO'],
      ['ESIA TICOMAN', 'ESCUELA SUPERIOR DE INGENIERIA Y ARQUITECTURA, UNIDAD TICOMAN'],
      ['ESIA ZACATENCO', 'ESCUELA SUPERIOR DE INGENIERIA Y ARQUITECTURA, UNIDAD ZACATENCO'],
      ['ESIME AZCAPOTZALCO', 'ESCUELA SUPERIOR DE INGENIERIA MECANICA Y ELECTRICA, UNIDAD AZCAPOTZALCO'],
      ['ESIME CULHUACAN', 'ESCUELA SUPERIOR DE INGENIERIA MECANICA Y ELECTRICA, UNIDAD CULHUACAN'],
      ['ESIME TICOMAN',	'ESCUELA SUPERIOR DE INGENIERIA MECANICA Y ELECTRICA, UNIDAD TICOMAN'],
      ['ESIME ZACATENCO', 'ESCUELA SUPERIOR DE INGENIERIA MECANICA Y ELECTRICA, UNIDAD ZACATENCO'],
      ['ESIQIE', 'ESCUELA SUPERIOR DE INGENIERIA QUIMICA E INDUSTRIAS EXTRACTIVAS'],
      ['ESIT', 'ESCUELA SUPERIOR DE INGENIERIA TEXTIL'],
      ['ISISA AZCAPOTZALCO', 'RED ACADEMICA DE INGENIERIA EN SISTEMAS AUTOMOTRICES (ISISA) - ESIME AZCAPOTZALCO'],
      ['ISISA CULHUACAN', 'RED ACADEMICA DE INGENIERIA EN SISTEMAS AUTOMOTRICES (ISISA) - ESIME CULHUACAN'],
      ['ISISA ESCOM', 'RED ACADEMICA DE INGENIERIA EN SISTEMAS AUTOMOTRICES (ISISA) - ESCOM'],
      ['ISISA TICOMAN',	'RED ACADEMICA DE INGENIERIA EN SISTEMAS AUTOMOTRICES (ISISA) - ESIME TICOMAN'],
      ['ISISA UPIICSA', 'RED ACADEMICA DE INGENIERIA EN SISTEMAS AUTOMOTRICES (ISISA) - UPIICSA'],
      ['ISISA UPIIG', 'RED ACADEMICA DE INGENIERIA EN SISTEMAS AUTOMOTRICES (ISISA) - UPIIG'],
      ['ISISA UPIIH', 'RED ACADEMICA DE INGENIERIA EN SISTEMAS AUTOMOTRICES (ISISA) - UPIIH'],
      ['ISISA UPIITA', 'RED ACADEMICA DE INGENIERIA EN SISTEMAS AUTOMOTRICES (ISISA) - UPIITA'],
      ['ISISA ZACATENCO', 'RED ACADEMICA DE INGENIERIA EN SISTEMAS AUTOMOTRICES (ISISA) - ESIME ZACATENCO'],
      ['UPII GUANAJUATO',	'UNIDAD PROFESIONAL INTERDISCIPLINARIA DE INGENIERIA, CAMPUS GUANAJUATO'],    
      ['UPII HIDALGO', 'UNIDAD PROFESIONAL INTERDISCIPLINARIA DE INGENIERIA, CAMPUS HIDALGO'],
      ['UPII ZACATECAS', 'UNIDAD PROFESIONAL INTERDISCIPLINARIA DE INGENIERIA, CAMPUS ZACATECAS'],
      ['UPIICSA', 'UNIDAD PROFESIONAL INTERDISCIPLINARIA DE INGENIERIA Y CIENCIAS SOCIALES Y ADMINISTRATIVAS'],
      ['UPIBI',	'UNIDAD PROFESIONAL INTERDISCIPLINARIA DE BIOTECNOLOGIA'],
      ['UPIITA', 'UNIDAD PROFESIONAL INTERDISCIPLINARIA EN INGENIERIA Y TECNOLOGIAS AVANZADAS'],
      ['CICS UMA', 'CENTRO INTERDISCIPLINARIO DE CIENCIAS DE LA SALUD, UNIDAD MILPA ALTA'],
      ['CICS UST', 'CENTRO INTERDISCIPLINARIO DE CIENCIAS DE LA SALUD, UNIDAD SANTO TOMAS'],
      ['ENCB', 'ESCUELA NACIONAL DE CIENCIAS BIOLOGICAS'],
      ['ENMH', 'ESCUELA NACIONAL DE MEDICINA Y HOMEOPATIA'],
      ['ESEO', 'ESCUELA SUPERIOR DE ENFERMERIA Y OBSTETRICIA'],
      ['ESM', 'ESCUELA SUPERIOR DE MEDICINA'],
      ['ESCA UST', 'ESCUELA SUPERIOR DE COMERCIO Y ADMINISTRACION, UNIDAD SANTO TOMAS'],
      ['ESCA TEPEPAN', 'ESCUELA SUPERIOR DE COMERCIO Y ADMINISTRACION, UNIDAD TEPEPAN'],
      ['ESE', 'ESCUELA SUPERIOR DE ECONOMIA'],
      ['EST', 'ESCUELA SUPERIOR DE TURISMO'],     
      ['CECyT 1 "GVV"', 'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 1 "GONZALO VAZQUEZ VELA"'],
      ['CECyT 2 "MBP"', 'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 2 "MIGUEL BERNARD PERALES"'],
      ['CECyT 3 "ERR"', 'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 3 "ESTANISLAO RAMIREZ RUIZ"'],
      ['CECyT 4 "LCR"', 'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 4 "LAZARO CARDENAS DEL RIO"'],
      ['CECyT 5 "BJG"',	'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 5 "BENITO JUAREZ GARCIA"'],
      ['CECyT 6 "MOM"',	'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 6 "MIGUEL OTHON DE MENDIZABAL"'],
      ['CECyT 7 "C"','CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 7 "CUAUHTEMOC"'],
      ['CECyT 8 "NBG"',	'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 8 "NARCISO BASSOLS GARCIA"'],
      ['CECyT 9 "JDBP"','CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 9 "JUAN DE DIOS BATIZ PAREDES"'],
      ['CECyT 10 "CVM"', 'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 10 "CARLOS VALLEJO MARQUEZ"'],
      ['CECyT 11 "WMP"', 'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 11 "WILFRIDO MASSIEU PEREZ"'],
      ['CECyT 12 "JMMP"', 'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 12 "JOSE MARIA MORELOS Y PAVON"'],
      ['CECyT 13 "RFM"', 'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 13 "RICARDO FLORES MAGON"'],
      ['CECyT 14 "LEES"',	'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 14 "LUIS ENRIQUE ERRO SOLER"'],
      ['CECyT 15 "DAE"', 'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 15 "DIODORO ANTUNEZ ECHEGARAY"'],
      ['CECyT 16 "HIDALGO"', 'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 16 "HIDALGO"'],
      ['CECyT 17 "LG"',	'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 17 "LEON GUANAJUATO"'],
      ['CECyT 18 "ZACATECAS"', 'CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLOGICOS No. 18 "ZACATECAS"'],
      ['CET 1 "WCB"',	'CENTRO DE ESTUDIOS TECNOLOGICOS No. 1 "WALTER CROSS BUCHANAN"'],
      ['CENTRO DE ESTUDIOS SUPERIORES DE MARTINEZ DE LA TORRE, S.C., CES MARTINEZ DE LA TORRE', 'CENTRO DE ESTUDIOS SUPERIORES DE MARTINEZ DE LA TORRE, S.C.'],	
      ['CENTRO DE ESTUDIOS TECNOLOGICOS Y UNIVERSITARIOS DEL GOLFO, CETUG', 'CENTRO DE ESTUDIOS TECNOLOGICOS Y UNIVERSITARIOS DEL GOLFO'],	
      ['CENTRO INTERDISCIPLINARIO DE CIENCIAS MARINAS, CICIMAR', 'CENTRO INTERDISCIPLINARIO DE CIENCIAS MARINAS'],	
      ['CENTRO LATINOAMERICANO DE ESTUDIOS SUPERIORES, CLAES', 'CENTRO LATINOAMERICANO DE ESTUDIOS SUPERIORES'],	
      ['CENTRO UNIVERSITARIO DORADOS, CUD', 'CENTRO UNIVERSITARIO DORADOS'],	
      ['CENTRO UNIVERSITARIO GRUPO SOL, CAMPUS CUAUHTEMOC, CUGS CUAUH', 'CENTRO UNIVERSITARIO GRUPO SOL, CAMPUS CUAUHTEMOC'],	
      ['CENTRO UNIVERSITARIO GRUPO SOL, CEM, S.C. PLANTEL SANTO TOMAS, CUGS CEM ST', 'CENTRO UNIVERSITARIO GRUPO SOL, CEM, S.C. PLANTEL SANTO TOMAS'],	
      ['CENTRO UNIVERSITARIO GRUPO SOL, PLANTEL CHALCO, CUGS CHALCO', 'CENTRO UNIVERSITARIO GRUPO SOL, PLANTEL CHALCO'],
      ['DIF DE ENFERMERIA, A.C., DIF', 'DIF DE ENFERMERIA, A.C.'],
      ['ESCUELA BANCARIA Y COMERCIAL, EBC', 'ESCUELA BANCARIA Y COMERCIAL'],
      ['ESCUELA TECNOLOGICA DE ZUMPANGO, A.C., ET ZUMPANGO', 'ESCUELA TECNOLOGICA DE ZUMPANGO, A.C.'],
      ['INSTITUTO BRITANICO DE LA CIUDAD DE PUEBLA, IB PUEBLA', 'INSTITUTO BRITANICO DE LA CIUDAD DE PUEBLA'],	
      ['INSTITUTO DE ESTUDIOS SUPERIORES "HIDALGO", IES HIDALGO', 'INSTITUTO DE ESTUDIOS SUPERIORES "HIDALGO"'],
      ['INSTITUTO ESPECIALIZADO EN COMPUTACION Y ADMINISTRACION "GAUSS JORDAN", A.C., IECA GAUSS JORDAN', 'INSTITUTO ESPECIALIZADO EN COMPUTACION Y ADMINISTRACION "GAUSS JORDAN", A.C.'],
      ['INSTITUTO DE ENSEÑANZA SUPERIOR EN CONTADURIA Y ADMINISTRACION, S.C., IESCA', 'INSTITUTO DE ENSEÑANZA SUPERIOR EN CONTADURIA Y ADMINISTRACION, S.C.'],
      ['INSTITUTO DE TURISMO STUDIO VIAJES, A.C., ITSV', 'INSTITUTO DE TURISMO STUDIO VIAJES, A.C.'],  
      ['INSTITUTO LEONARDO BRAVO, A.C., PLANTEL CENTRO, ILB', 'INSTITUTO LEONARDO BRAVO, A.C.'],
      ['INSTITUTO LEONARDO BRAVO, A.C., PLANTEL LA RAZA, ILB LA RAZA', 'INSTITUTO LEONARDO BRAVO, A.C., PLANTEL LA RAZA'], 	
      ['INSTITUTO LEONARDO BRAVO, A.C., PLANTEL VERACRUZ, ILB VERACRUZ', 'INSTITUTO LEONARDO BRAVO, A.C., PLANTEL VERACRUZ'],
      ['INSTITUTO MEXICANO DE EDUCACION PROFESIONAL, PLANTEL SANTA MARTHA, IMEP STM', 'INSTITUTO MEXICANO DE EDUCACION PROFESIONAL, PLANTEL SANTA MARTHA'],
      ['INSTITUTO MEXICANO DE EDUCACION PROFESIONAL, PLANTEL IZTAPALAPA, IMEP ZAR', 'INSTITUTO MEXICANO DE EDUCACION PROFESIONAL, PLANTEL IZTAPALAPA'],	
      ['INSTITUTO SUPERIOR DE ESTUDIOS COMERCIALES, ISECO', 'INSTITUTO SUPERIOR DE ESTUDIOS COMERCIALES'],
      ['INSTITUTO TECNICO Y BANCARIO, "SAN CARLOS, ITB SAN CARLOS', 'INSTITUTO TECNICO Y BANCARIO, "SAN CARLOS"'],
      ['INSTITUTO TECNOLOGICO DE ESTUDIOS SUPERIORES DEL SURESTE, A.C., ITESS', 'INSTITUTO TECNOLOGICO DE ESTUDIOS SUPERIORES DEL SURESTE, A.C.'],	
      ['INSTITUTO TECNICO PROFESIONAL PANAMERICANO, ITPP', 'INSTITUTO TECNICO PROFESIONAL PANAMERICANO'],	      
      ['UNIDAD EDUCATIVA " ERNESTO PERALTA Q.", A.C., UE ERNESTO PERALTA Q.', 'UNIDAD EDUCATIVA " ERNESTO PERALTA Q.", A.C.'],
      ['UNIVERSIDAD ARKOS, U ARKOS', 'UNIVERSIDAD ARKOS'],
      ['UNIVERSIDAD ISEC, PLANTEL DEL VALLE, ISEC DEL VALLE', 'UNIVERSIDAD ISEC, PLANTEL DEL VALLE'],
      ['UNIVERSIDAD DE CELAYA', 'UNIVERSIDAD DE CELAYA'],      	
      ['UNIVERSIDAD FRAY LUCA PACCIOLI, UFLP', 'UNIVERSIDAD FRAY LUCA PACCIOLI'],	
      ['UNIVERSIDAD PRIVADA DE IRAPUATO, UPI', 'UNIVERSIDAD PRIVADA DE IRAPUATO'],	
      ['UNIVERSIDAD TECNOLOGICA DEL CENTRO DE MEXICO, CAMPUS CELAYA, UTCM CELAYA', 'UNIVERSIDAD TECNOLOGICA DEL CENTRO DE MEXICO, CAMPUS CELAYA'],
      ['UNIVERSIDAD TECNOLOGICA INTERNACIONAL, UTI', 'UNIVERSIDAD TECNOLOGICA INTERNACIONAL'],
      ['UNIVERSIDAD TECNOLOGICA MESOAMERICANA, S.C., UTM', 'UNIVERSIDAD TECNOLOGICA MESOAMERICANA, S.C.'],
      ['UNIVERSIDAD TECNOLOGICA DEL SURESTE, S.C., PLANTEL CAMPECHE, UTS CAMPE', 'UNIVERSIDAD TECNOLOGICA DEL SURESTE, S.C., PLANTEL CAMPECHE'],	
      ['UNIVERSIDAD TECNOLOGICA DEL SURESTE, S.C., PLANTEL COATZACOALCOS, UTS COATZ', 'UNIVERSIDAD TECNOLOGICA DEL SURESTE, S.C., PLANTEL COATZACOALCOS'],		
	]

  end

  def self.options_for_numero_relacion
    [
      ["001", "001"],
      ["002", "002"],
      ["003", "003"],
      ["004", "004"],
      ["005", "005"],
      ["006", "006"],
      ["007", "007"],
      ["008", "008"],
      ["009", "009"],
      ["010", "010"],
      ["011", "011"],
      ["012", "012"],
      ["013", "013"],
      ["014", "014"],
      ["015", "015"],
      ["016", "016"],
      ["017", "017"],
      ["018", "018"],
      ["019", "019"],
      ["020", "020"],
      ["021", "021"],
      ["022", "022"],
      ["023", "023"],
      ["024", "024"],
      ["025", "025"],
      ["026", "026"],
      ["027", "027"],
      ["028", "028"],
      ["029", "029"],
      ["030", "030"],
      ["031", "031"],
      ["032", "032"],
      ["033", "033"],
      ["034", "034"],
      ["035", "035"],
      ["036", "036"],
      ["037", "037"],
      ["038", "038"],
      ["039", "039"],
      ["040", "040"],
      ["041", "041"],
      ["042", "042"],
      ["043", "043"],
      ["044", "044"],
      ["045", "045"],
      ["046", "046"],
      ["047", "047"],
      ["048", "048"],
      ["049", "049"],
      ["050", "050"],
      ["051", "051"],
      ["052", "052"],
      ["053", "053"],
      ["054", "054"],
      ["055", "055"],
      ["056", "056"],
      ["057", "057"],
      ["058", "058"],
      ["059", "059"],
      ["060", "060"],
      ["061", "061"],
      ["062", "062"],
      ["063", "063"],
      ["064", "064"],
      ["065", "065"],
      ["066", "066"],
      ["067", "067"],
      ["068", "068"],
      ["069", "069"],
      ["070", "070"],
      ["071", "071"],
      ["072", "072"],
      ["073", "073"],
      ["074", "074"],
      ["075", "075"],
      ["076", "076"],
      ["077", "077"],
      ["078", "078"],
      ["079", "079"],
      ["080", "080"],
      ["081", "081"],
      ["082", "082"],
      ["083", "083"],
      ["084", "084"],
      ["085", "085"],
      ["086", "086"],
      ["087", "087"],
      ["088", "088"],
      ["089", "089"],
      ["090", "090"],
      ["091", "091"],
      ["092", "092"],
      ["093", "093"],
      ["094", "094"],
      ["095", "095"],
      ["096", "096"],
      ["097", "097"],
      ["098", "098"],
      ["099", "099"],
      ["100", "100"],
      ["200", "200"],
      ["201", "201"],
      ["202", "202"],
      ["203", "203"],
      ["204", "204"],
      ["205", "205"],
      ["206", "206"],
      ["207", "207"],
      ["208", "208"],
      ["209", "209"],
      ["210", "210"]
    ]
  end

  def self.fecha_alfanumerica
    dia = Time.now.day
    if dia == 1
      dia = "01"
    elsif dia == 2
      dia = "02"
    elsif dia == 3
      dia = "03"
    elsif dia == 4
      dia = "04"
    elsif dia == 5
      dia = "05"
    elsif dia == 6
      dia = "06"
    elsif dia == 7
      dia = "07"
    elsif dia == 8
      dia = "08"
    elsif dia == 9
      dia = "09"
    end

    mes = Time.now.month
    if mes == 1
      mes = "ENERO"
    elsif mes == 2
      mes = "FEBRERO"
    elsif mes == 3
      mes = "MARZO"
    elsif mes == 4
      mes = "ABRIL"
    elsif mes == 5
      mes = "MAYO"
    elsif mes == 6
      mes = "JUNIO"
    elsif mes == 7
      mes = "JULIO"
    elsif mes == 8
      mes = "AGOSTO"
    elsif mes == 9
      mes = "SEPTIEMBRE"
    elsif mes == 10
      mes = "OCTUBRE"
    elsif mes == 11
      mes = "NOVIEMBRE"
    elsif mes == 12
      mes = "DICIEMBRE"
    end

    anio = Time.now.year

    fecha = dia.to_s + " DE " + mes.to_s + " DE " + anio.to_s
  end

end
