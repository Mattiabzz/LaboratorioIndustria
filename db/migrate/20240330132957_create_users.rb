class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :nome
      t.string :cognome
      t.string :email
      t.integer :eta
      t.text :codice_fiscale

      t.timestamps
    end
  end
end
