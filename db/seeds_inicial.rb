administrador = Role.create({nombre: "Administrador", descripcion: "Administrador del sistema"})
direccion = Role.create({nombre: "Dirección", descripcion: "Director de Egresados y Servicio Social"})
departamento = Role.create({nombre: "Departamento", descripcion: "Departamento de Control y Trámite de Servicio Social"})
captura = Role.create({nombre: "Captura", descripcion: "Captura de constancias"})

usuario1 = User.create({nombre: "Luis Alberto", apellido_paterno: "Mendez", apellido_materno: "Cruz", email: "lumendez@ipn.mx",
password: "123456", password_confirmation: "123456", role_id: administrador.id})
