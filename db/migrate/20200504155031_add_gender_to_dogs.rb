class AddGenderToDogs < ActiveRecord::Migration[6.0]
  def change
    add_column :dogs, :gender, :string
  end
end
