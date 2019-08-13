class CreateConstanciaDocumentos < ActiveRecord::Migration[5.2]
  def change
    create_table :constancia_documentos do |t|
      t.string :folio
      t.string :numero_relacion
      t.string :numero_oficio
      t.string :numero_registro
      t.string :codigo_prestatario
      t.string :clave_programa
      t.string :fecha
      t.string :nombre
      t.string :boleta
      t.string :unidad_academica
      t.string :programa_academico
      t.string :periodo
      t.string :prestatario
      t.boolean :constancia_emitida

      t.timestamps
    end
  end
end
