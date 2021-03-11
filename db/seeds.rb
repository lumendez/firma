require 'csv'

csv_text = File.read(Rails.root.join('lib','seeds','relacion.csv'))
csv = CSV.parse(csv_text, headers: true)

csv.each do |row|

  id = row['ID']
  relacion = row['RELACION']
  documento = ConstanciaDocumento.where(id: id)
  documento.update(numero_relacion: relacion)

end
