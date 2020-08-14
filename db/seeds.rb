require 'csv'

csv_text = File.read(Rails.root.join('lib','seeds','bloqueunoboletas.csv'))
csv = CSV.parse(csv_text, headers: true)

csv.each do |row|

  id = row['ID']
  boleta = row['BOLETA']
  documento = ConstanciaDocumento.where(id: id)
  documento.update(boleta: boleta)

end
