require 'csv'

csv_text = File.read(Rails.root.join('lib','seeds','oficios.csv'))
csv = CSV.parse(csv_text, headers: true)

csv.each do |row|

  id = row['ID']
  documento = ConstanciaDocumento.where(id: id)
  documento.update(numero_oficio: row['OFICIO'])

end
