class CreateUtentes < ActiveRecord::Migration[7.1]
  def change
    create_table :utentes do |t|
      t.string :nome
      t.string :cognome
      t.integer :eta
      t.string :email
      t.string :codice_fiscale
      t.string :text

      t.timestamps
    end
  end
end
