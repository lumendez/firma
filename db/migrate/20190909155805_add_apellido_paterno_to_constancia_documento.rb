class AddApellidoPaternoToConstanciaDocumento < ActiveRecord::Migration[5.2]
  def change
    add_column :constancia_documentos, :apellido_paterno, :string
  end
end
