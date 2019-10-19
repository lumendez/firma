class AddCorreoToConstanciaDocumentos < ActiveRecord::Migration[5.2]
  def change
    add_column :constancia_documentos, :correo, :string
  end
end
