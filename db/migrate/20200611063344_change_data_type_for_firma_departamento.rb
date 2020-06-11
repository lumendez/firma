class ChangeDataTypeForFirmaDepartamento < ActiveRecord::Migration[5.2]
  def self.up
    change_table :constancia_documentos do |t|
      t.change :firma_departamento, :longtext
    end
  end
  def self.down
    change_table :constancia_documentos do |t|
      t.change :firma_departamento, :longtext
    end
  end
end
