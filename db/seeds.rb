require 'csv'

csv_text = File.read(Rails.root.join('lib','seeds','30marzo23.csv'))
csv = CSV.parse(csv_text, headers: true)

csv.each do |row|

  id = row['ID']
  numero_relacion = row['RELACION']
  documento = ConstanciaDocumento.where(id: id)
  documento.update(firma_direccion: nil, firma_departamento: nil, numero_relacion: numero_relacion)

end
