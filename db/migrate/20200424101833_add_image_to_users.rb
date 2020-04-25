class AddImageToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :image, :string
    add_column :microposts, :image, :string
  end
end
