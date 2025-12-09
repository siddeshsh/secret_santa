class CreateAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :assignments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :assigned_to, null: false, foreign_key: { to_table: :users }
      t.string :event_type, null: false, default: 'secret_santa'
      t.boolean :revealed, default: false

      t.timestamps
    end

    add_index :assignments, [:user_id, :event_type], unique: true
  end
end
