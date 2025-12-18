class AddReadAtToMessages < ActiveRecord::Migration[7.0]
  def change
    add_column :messages, :read_at, :datetime
    add_index :messages, [:assignment_id, :read_at]
  end
end
