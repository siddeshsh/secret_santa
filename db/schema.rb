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

ActiveRecord::Schema[7.0].define(version: 2025_12_10_000001) do
  create_table "assignments", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "assigned_to_id", null: false
    t.string "event_type", default: "secret_santa", null: false
    t.boolean "revealed", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_to_id"], name: "index_assignments_on_assigned_to_id"
    t.index ["user_id", "event_type"], name: "index_assignments_on_user_id_and_event_type", unique: true
    t.index ["user_id"], name: "index_assignments_on_user_id"
  end

  create_table "messages", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "assignment_id", null: false
    t.bigint "sender_id", null: false
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "read_at"
    t.index ["assignment_id", "created_at"], name: "index_messages_on_assignment_id_and_created_at"
    t.index ["assignment_id", "read_at"], name: "index_messages_on_assignment_id_and_read_at"
    t.index ["assignment_id"], name: "index_messages_on_assignment_id"
    t.index ["sender_id"], name: "index_messages_on_sender_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "preferences"
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "assignments", "users"
  add_foreign_key "assignments", "users", column: "assigned_to_id"
  add_foreign_key "messages", "assignments"
  add_foreign_key "messages", "users", column: "sender_id"
end
