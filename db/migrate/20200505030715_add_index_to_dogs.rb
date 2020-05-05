class AddIndexToDogs < ActiveRecord::Migration[6.0]
  def change
    add_index :dogs, [:user_id, :created_at]
  end
end
