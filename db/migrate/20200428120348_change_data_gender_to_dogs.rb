class ChangeDataGenderToDogs < ActiveRecord::Migration[6.0]
  def change
    add_column :dogs, :color, :string
  end
end
