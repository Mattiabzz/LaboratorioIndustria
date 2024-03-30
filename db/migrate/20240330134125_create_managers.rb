class CreateManagers < ActiveRecord::Migration[7.1]
  def change
    create_table :managers do |t|
      t.string :nome
      t.string :cognome
      t.string :email

      t.timestamps
    end
  end
end
