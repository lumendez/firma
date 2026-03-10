require 'csv'

csv_text = File.read(Rails.root.join('lib','seeds','06405-06757.csv'), encoding: 'bom|utf-8')
csv = CSV.parse(csv_text, headers: true)

csv.each do |row|
  t = ConstanciaDocumento.new(
    numero_registro: row['REGISTRO'],
    numero_relacion: row['RELACION'],
    numero_oficio: row['OFICIO'],
    codigo_prestatario: row['CODIGO'],
    clave_programa: row['PROGRAMA'],
    fecha: row['FECHA'],
    nombre: row['NOMBRE'],
    apellido_paterno: row['PATERNO'],
    apellido_materno: row['MATERNO'],
    boleta: row['BOLETA'],
    unidad_academica: row['UNIDAD'],
    programa_academico: row['CARRERA'],
    periodo: row['FECHA TEXTO'],
    prestatario: row['PRESTATARIO'],
    constancia_emitida: row['EMITIDA'] || false,
    folio: "Lic. Beatriz Rangel Romo",
    user_id: 1   
  )

  if t.save
    puts "Guardado: #{t.boleta}"
  else
    puts "Error guardando #{t.boleta}: #{t.errors.full_messages.join(', ')}"
  end
end

