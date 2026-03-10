# Crear roles
administrador = Role.create({nombre: "Administrador", descripcion: "Administrador del sistema"})
direccion = Role.create({nombre: "Dirección", descripcion: "Director de Egresados y Servicio Social"})
departamento = Role.create({nombre: "Departamento", descripcion: "Departamento de Control y Trámite de Servicio Social"})
captura = Role.create({nombre: "Captura", descripcion: "Captura de constancias"})

# Crear usuario administrador
usuario1 = User.find_or_create_by(id: 1) do |u|
  u.nombre = "Daniela Abigail"
  u.apellido_paterno = "Vazquez"
  u.apellido_materno = "Oran"
  u.email = "dvazquezo@ipn.mx"
  u.password = "123456"
  u.password_confirmation = "123456"
  u.role_id = administrador.id
end

# Crear usuario Dirección
usuario_direccion = User.find_or_create_by(email: "dess@ipn.mx") do |u| 
  u.nombre = "Beatriz"
  u.apellido_paterno = "Rangel"
  u.apellido_materno = "Romo"
  u.password = "123456"
  u.password_confirmation = "123456"
  u.role_id = direccion.id
end
