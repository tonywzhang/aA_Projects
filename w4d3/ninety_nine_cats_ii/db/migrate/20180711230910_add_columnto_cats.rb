class AddColumntoCats < ActiveRecord::Migration[5.1]
  def change
    add_column :cats, :user_id, :integer, null:false
    add_index :cats, :user_id, unique: true
  end
end
