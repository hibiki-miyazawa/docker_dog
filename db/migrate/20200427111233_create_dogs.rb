class CreateDogs < ActiveRecord::Migration[6.0]
  def change
    create_table :dogs do |t|
      t.string :name
      t.integer :sex
      t.date :birthday
      t.string :type
      t.string :pospital
      t.string :salon
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
