# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_09_155842) do

  create_table "constancia_documentos", force: :cascade do |t|
    t.string "folio"
    t.string "numero_relacion"
    t.string "numero_oficio"
    t.string "numero_registro"
    t.string "codigo_prestatario"
    t.string "clave_programa"
    t.string "fecha"
    t.string "nombre"
    t.string "boleta"
    t.string "unidad_academica"
    t.string "programa_academico"
    t.string "periodo"
    t.string "prestatario"
    t.boolean "constancia_emitida"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "firma_direccion"
    t.string "firma_departamento"
    t.string "apellido_paterno"
    t.string "apellido_materno"
  end

end
