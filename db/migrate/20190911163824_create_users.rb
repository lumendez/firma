class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :nombre
      t.string :apellido_paterno
      t.string :apellido_materno
      t.references :role, foreign_key: true

      t.timestamps
    end
  end
end
