# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#administrador = Role.create({nombre: "Administrador", descripcion: "Administrador del sistema"})
#direccion = Role.create({nombre: "Dirección", descripcion: "Director de Egresados y Servicio Social"})
#departamento = Role.create({nombre: "Departamento", descripcion: "Departamento de Control y Trámite de Servicio Social"})
#captura = Role.create({nombre: "Captura", descripcion: "Captura de constancias"})

#usuario = User.create({nombre: "Luis Alberto ", apellido_paterno: "Mendez", apellido_materno: "Cruz", email: "lumendez@ipn.mx",
#password: "123456", password_confirmation: "123456", role_id: administrador.id})

const1 = ConstanciaDocumento.create({folio: "188583", numero_relacion: "27",numero_oficio: "DESS/DSS/14617/19",
numero_registro: "18053/0263", codigo_prestatario: "100101700", clave_programa: "1", fecha: "17 DE SEPTIEMBRE DE 2019", nombre: "HECTOR JOSE",
boleta: "2014530255", unidad_academica: "ESCUELA SUPERIOR DE ENFERMERIA Y OBTETRICIA", programa_academico: "LICENCIADO EN ENFERMERIA", periodo: "01 DE AGOSTO DE 2018 AL 31 DE JULIO DE 2019",
prestatario: "ESCUELA SUPERIOR DE ENFERMERIA Y OBTETRICIA", apellido_paterno: "CERVANTES", apellido_materno: "HERNANDEZ", user_id: "2"})

const2 = ConstanciaDocumento.create({folio: "188584", numero_relacion: "27",numero_oficio: "DESS/DSS/14618/19",
numero_registro: "18053/0234", codigo_prestatario: "100101700", clave_programa: "1", fecha: "17 DE SEPTIEMBRE DE 2019", nombre: "YESSENIA",
boleta: "2014530844", unidad_academica: "ESCUELA SUPERIOR DE ENFERMERIA Y OBTETRICIA", programa_academico: "LICENCIADO EN ENFERMERIA", periodo: "01 DE AGOSTO DE 2018 AL 31 DE JULIO DE 2019",
prestatario: "ESCUELA SUPERIOR DE ENFERMERIA Y OBTETRICIA", apellido_paterno: "AGUILAR", apellido_materno: "GUERRERO", user_id: "2"})

const3 = ConstanciaDocumento.create({folio: "188585", numero_relacion: "27",numero_oficio: "DESS/DSS/14619/19",
numero_registro: "18053/0424", codigo_prestatario: "100101700", clave_programa: "1", fecha: "17 DE SEPTIEMBRE DE 2019", nombre: "ITALIA BERENICE",
boleta: "2014530847", unidad_academica: "ESCUELA SUPERIOR DE ENFERMERIA Y OBTETRICIA", programa_academico: "LICENCIADO EN ENFERMERIA", periodo: "01 DE AGOSTO DE 2018 AL 31 DE JULIO DE 2019",
prestatario: "ESCUELA SUPERIOR DE ENFERMERIA Y OBTETRICIA", apellido_paterno: "AGUILAR", apellido_materno: "VAZQUEZ", user_id: "2"})

const4 = ConstanciaDocumento.create({folio: "188586", numero_relacion: "27",numero_oficio: "DESS/DSS/14620/19",
numero_registro: "18053/0255", codigo_prestatario: "100101700", clave_programa: "1", fecha: "17 DE SEPTIEMBRE DE 2019", nombre: "ITZEL",
boleta: "2014530867", unidad_academica: "ESCUELA SUPERIOR DE ENFERMERIA Y OBTETRICIA", programa_academico: "LICENCIADO EN ENFERMERIA", periodo: "01 DE AGOSTO DE 2018 AL 31 DE JULIO DE 2019",
prestatario: "ESCUELA SUPERIOR DE ENFERMERIA Y OBTETRICIA", apellido_paterno: "AVILES", apellido_materno: "MARTINEZ", user_id: "2"})

const5 = ConstanciaDocumento.create({folio: "188587", numero_relacion: "27",numero_oficio: "DESS/DSS/14621/19",
numero_registro: "18053/0249", codigo_prestatario: "100101700", clave_programa: "1", fecha: "17 DE SEPTIEMBRE DE 2019", nombre: "GABRIELA",
boleta: "2014530255", unidad_academica: "ESCUELA SUPERIOR DE ENFERMERIA Y OBTETRICIA", programa_academico: "LICENCIADO EN ENFERMERIA", periodo: "01 DE AGOSTO DE 2018 AL 31 DE JULIO DE 2019",
prestatario: "ESCUELA SUPERIOR DE ENFERMERIA Y OBTETRICIA", apellido_paterno: "DE LA CRUZ", apellido_materno: "CORTES", user_id: "2"})

const6 = ConstanciaDocumento.create({folio: "188588", numero_relacion: "27",numero_oficio: "DESS/DSS/14622/19",
numero_registro: "18053/0453", codigo_prestatario: "100101700", clave_programa: "1", fecha: "17 DE SEPTIEMBRE DE 2019", nombre: "NAYELI",
boleta: "2014530765", unidad_academica: "ESCUELA SUPERIOR DE ENFERMERIA Y OBTETRICIA", programa_academico: "LICENCIADO EN ENFERMERIA", periodo: "01 DE AGOSTO DE 2018 AL 31 DE JULIO DE 2019",
prestatario: "ESCUELA SUPERIOR DE ENFERMERIA Y OBTETRICIA", apellido_paterno: "AVILA", apellido_materno: "DIAZ", user_id: "2"})

const7 = ConstanciaDocumento.create({folio: "188589", numero_relacion: "27",numero_oficio: "DESS/DSS/14623/19",
numero_registro: "18053/0232", codigo_prestatario: "100101700", clave_programa: "1", fecha: "17 DE SEPTIEMBRE DE 2019", nombre: "MONSERRAT",
boleta: "2014530254", unidad_academica: "ESCUELA SUPERIOR DE ENFERMERIA Y OBTETRICIA", programa_academico: "LICENCIADO EN ENFERMERIA", periodo: "01 DE AGOSTO DE 2018 AL 31 DE JULIO DE 2019",
prestatario: "ESCUELA SUPERIOR DE ENFERMERIA Y OBTETRICIA", apellido_paterno: "ESQUIVEL", apellido_materno: "MORALES", user_id: "2"})

const8 = ConstanciaDocumento.create({folio: "188590", numero_relacion: "27",numero_oficio: "DESS/DSS/14624/19",
numero_registro: "18053/0263", codigo_prestatario: "100101700", clave_programa: "1", fecha: "17 DE SEPTIEMBRE DE 2019", nombre: "ELIZABETH",
boleta: "2014530255", unidad_academica: "ESCUELA SUPERIOR DE ENFERMERIA Y OBTETRICIA", programa_academico: "LICENCIADO EN ENFERMERIA", periodo: "01 DE AGOSTO DE 2018 AL 31 DE JULIO DE 2019",
prestatario: "ESCUELA SUPERIOR DE ENFERMERIA Y OBTETRICIA", apellido_paterno: "FIERROS", apellido_materno: "CRUZ", user_id: "2"})

const9 = ConstanciaDocumento.create({folio: "188591", numero_relacion: "27",numero_oficio: "DESS/DSS/14625/19",
numero_registro: "18053/0567", codigo_prestatario: "100101700", clave_programa: "1", fecha: "17 DE SEPTIEMBRE DE 2019", nombre: "HECTOR JOSE",
boleta: "2014530765", unidad_academica: "ESCUELA SUPERIOR DE ENFERMERIA Y OBTETRICIA", programa_academico: "LICENCIADO EN ENFERMERIA", periodo: "01 DE AGOSTO DE 2018 AL 31 DE JULIO DE 2019",
prestatario: "ESCUELA SUPERIOR DE ENFERMERIA Y OBTETRICIA", apellido_paterno: "CERVANTES", apellido_materno: "HERNANDEZ", user_id: "2"})

const10 = ConstanciaDocumento.create({folio: "188592", numero_relacion: "27",numero_oficio: "DESS/DSS/14626/19",
numero_registro: "18053/0965", codigo_prestatario: "100101700", clave_programa: "1", fecha: "17 DE SEPTIEMBRE DE 2019", nombre: "SANDRA CAROLINA",
boleta: "2014530342", unidad_academica: "ESCUELA SUPERIOR DE ENFERMERIA Y OBTETRICIA", programa_academico: "LICENCIADO EN ENFERMERIA", periodo: "01 DE AGOSTO DE 2018 AL 31 DE JULIO DE 2019",
prestatario: "ESCUELA SUPERIOR DE ENFERMERIA Y OBTETRICIA", apellido_paterno: "GOMEZ", apellido_materno: "LOPEZ", user_id: "2"})
