class AddImageNameColumnToDogs < ActiveRecord::Migration[6.0]
  def change
    add_column :dogs, :image_name, :string
  end
end
