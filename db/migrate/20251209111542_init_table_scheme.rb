class InitTableScheme < ActiveRecord::Migration[7.0]
  def up
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
  end

  def down
    drop_table :assignments
    drop_table :users
  end
end
