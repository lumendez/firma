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

ActiveRecord::Schema.define(version: 2020_06_11_064635) do

  create_table "constancia_documentos", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
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
    t.text "firma_direccion", limit: 4294967295
    t.text "firma_departamento", limit: 4294967295
    t.string "apellido_paterno"
    t.string "apellido_materno"
    t.bigint "user_id"
    t.string "uuid"
    t.string "correo"
    t.index ["user_id"], name: "index_constancia_documentos_on_user_id"
  end

  create_table "roles", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "nombre"
    t.string "apellido_paterno"
    t.string "apellido_materno"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "otp_secret_key"
    t.integer "otp_module", default: 0
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "constancia_documentos", "users"
  add_foreign_key "users", "roles"
end
