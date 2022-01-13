require 'csv'

csv_text = File.read(Rails.root.join('lib','seeds','20diciembre21.csv'))
csv = CSV.parse(csv_text, headers: true)

csv.each do |row|
  t = ConstanciaDocumento.new

  t.numero_registro = row['REGISTRO']
  t.id = row['ID']
  t.numero_relacion = row['RELACION']
  t.numero_oficio = row['OFICIO']
  t.codigo_prestatario = ""
  t.clave_programa = ""
  t.fecha = row['FECHA']
  t.nombre = row['NOMBRE']
  t.apellido_paterno = row['PATERNO']
  t.apellido_materno = row['MATERNO']
  t.boleta = row['BOLETA']
  t.unidad_academica = row['UNIDAD']
  t.programa_academico = row['CARRERA']
  t.periodo = ""
  t.prestatario = ""
  t.constancia_emitida = row['EMITIDA']
  t.user_id = row['USERID']
  t.correo = ""
  t.created_at = DateTime.new(2021, 12, 20, 22, 35, 0)
  t.updated_at = DateTime.new(2021, 12, 20, 22, 35, 0)

  t.save
end
