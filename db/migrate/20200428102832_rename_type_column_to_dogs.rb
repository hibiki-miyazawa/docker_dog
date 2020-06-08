class RenameTypeColumnToDogs < ActiveRecord::Migration[6.0]
  def change
    rename_column :dogs, :type, :breed
  end
end
