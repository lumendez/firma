class AddApellidoMaternoToConstanciaDocumento < ActiveRecord::Migration[5.2]
  def change
    add_column :constancia_documentos, :apellido_materno, :string
  end
end
