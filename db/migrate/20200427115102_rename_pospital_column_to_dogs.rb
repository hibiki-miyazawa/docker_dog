class RenamePospitalColumnToDogs < ActiveRecord::Migration[6.0]
  def change
    rename_column :dogs, :pospital, :hospital
  end
end
