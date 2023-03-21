require 'csv'

csv_text = File.read(Rails.root.join('lib','seeds','21marzo23.csv'))
csv = CSV.parse(csv_text, headers: true)

csv.each do |row|
  t = ConstanciaDocumento.new

  t.numero_registro = row['REGISTRO']
  t.id = row['ID']
  t.numero_relacion = row['RELACION']
  t.numero_oficio = row['OFICIO']
  t.codigo_prestatario = row['CODIGO']
  t.clave_programa = row['PROGRAMA']
  t.fecha = row['FECHA']
  t.nombre = row['NOMBRE']
  t.apellido_paterno = row['PATERNO']
  t.apellido_materno = row['MATERNO']
  t.boleta = row['BOLETA']
  t.unidad_academica = row['UNIDAD']
  t.programa_academico = row['CARRERA']
  t.periodo = row['FECHA TEXTO']
  t.prestatario = row['PRESTATARIO']
  t.constancia_emitida = row['EMITIDA']
  t.folio = "Lic. Edgar Gregorio Cárcamo Villalobos"
  t.user_id = row['USERID']

  t.save
end
