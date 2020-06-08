class RenameSexColumnToDogs < ActiveRecord::Migration[6.0]
  def change
    rename_column :dogs, :sex, :gender
  end
end
