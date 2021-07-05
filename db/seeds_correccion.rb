require 'csv'

csv_text = File.read(Rails.root.join('lib','seeds','12junio21.csv'))
csv = CSV.parse(csv_text, headers: true)

csv.each do |row|

  id = row['ID']
  oficio = row['OFICIO']
  programa = row['CARRERA']
  periodo = row['FECHA TEXTO']
  prestatario = row['PRESTATARIO']
  documento = ConstanciaDocumento.where(id: id)
  documento.update(numero_oficio: oficio, programa_academico: programa, periodo: periodo, prestatario: prestatario)

end