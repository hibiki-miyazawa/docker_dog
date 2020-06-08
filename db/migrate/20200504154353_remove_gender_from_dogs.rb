class RemoveGenderFromDogs < ActiveRecord::Migration[6.0]
  def up

    remove_column :dogs, :gender
  end

  def down
    add_column :dogs, :gender, :string
  end
end
