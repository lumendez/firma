class AddUuidToConstanciaDocumentos < ActiveRecord::Migration[5.2]
  def change
    add_column :constancia_documentos, :uuid, :string
  end
end
