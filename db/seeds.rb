require 'csv'

csv_text = File.read(Rails.root.join('lib','seeds','constanciasjulio.csv'))
csv = CSV.parse(csv_text, headers: true)

csv.each do |row|
  t = ConstanciaDocumento.new

  t.id = row['id']
  t.numero_relacion = row['numero_relacion']
  t.numero_oficio = row['numero_oficio']
  t.numero_registro = row['numero_registro']
  t.codigo_prestatario = row['codigo_prestatario']
  t.clave_programa = row['clave_programa']
  t.fecha = row['fecha']
  t.nombre = row['nombre']
  t.boleta = row['boleta']
  t.unidad_academica = row['unidad_academica']
  t.programa_academico = row['programa_academico']
  t.periodo = row['periodo']
  t.prestatario = row['prestatario']
  t.constancia_emitida = row['constancia_emitida']
  t.created_at = row['created_at']
  t.updated_at = row['updated_at']
  t.apellido_paterno = row['apellido_paterno']
  t.apellido_materno = row['apellido_materno']
  t.user_id = row['user_id']
  t.uuid = row['uuid']
  t.correo = row['correo']

  t.save
end
