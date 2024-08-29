require 'csv'

csv_text = File.read(Rails.root.join('lib','seeds','12junio21.csv'))
csv = CSV.parse(csv_text, headers: true)

csv.each do |row|

  id = row['ID']
  fecha = row['FECHA']
  documento = ConstanciaDocumento.where(id: id)
  documento.update(fecha: fecha)

end