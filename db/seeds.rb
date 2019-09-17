# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

administrador = Role.create({nombre: "Administrador", descripcion: "Administrador del sistema"})
direccion = Role.create({nombre: "Dirección", descripcion: "Director de Egresados y Servicio Social"})
departamento = Role.create({nombre: "Departamento", descripcion: "Departamento de Control y Trámite de Servicio Social"})
captura = Role.create({nombre: "Captura", descripcion: "Captura de constancias"})

usuario = User.create({nombre: "Luis Alberto ", apellido_paterno: "Mendez", apellido_materno: "Cruz", email: "lumendez@ipn.mx",
password: "123456", password_confirmation: "123456", role_id: administrador.id})
