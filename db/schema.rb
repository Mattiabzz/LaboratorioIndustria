# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_18_093239) do
  create_table "events", force: :cascade do |t|
    t.string "nome"
    t.string "luogo"
    t.datetime "data_inizio"
    t.text "descrizione"
    t.integer "capacita"
    t.integer "capacita_corrente"
    t.integer "manager_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "data_fine"
    t.string "citta"
    t.string "via"
    t.index ["manager_id"], name: "index_events_on_manager_id"
  end

  create_table "managers", force: :cascade do |t|
    t.string "nome"
    t.string "cognome"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password"
  end

  create_table "notify_managers", force: :cascade do |t|
    t.text "tipo"
    t.integer "manager_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "letto", default: false
    t.index ["manager_id"], name: "index_notify_managers_on_manager_id"
  end

  create_table "notify_users", force: :cascade do |t|
    t.text "tipo"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "letto", default: false
    t.index ["user_id"], name: "index_notify_users_on_user_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.datetime "data_prenotazione"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_reservations_on_event_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "nome"
    t.string "cognome"
    t.string "email"
    t.integer "eta"
    t.text "codice_fiscale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password"
  end

  add_foreign_key "events", "managers"
  add_foreign_key "notify_managers", "managers"
  add_foreign_key "notify_users", "users"
  add_foreign_key "reservations", "events"
  add_foreign_key "reservations", "users"
end
