class AddFirmaDireccionToConstanciaDocumento < ActiveRecord::Migration[5.2]
  def change
    add_column :constancia_documentos, :firma_direccion, :string
  end
end
