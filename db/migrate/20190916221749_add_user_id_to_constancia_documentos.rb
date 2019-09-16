class AddUserIdToConstanciaDocumentos < ActiveRecord::Migration[5.2]
  def change
    add_reference :constancia_documentos, :user, foreign_key: true
  end
end
