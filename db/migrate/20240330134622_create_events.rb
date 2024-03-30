class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :nome
      t.string :luogo
      t.datetime :data
      t.text :descrizione
      t.integer :capacita
      t.integer :capacita_corrente
      t.references :manager, null: false, foreign_key: true

      t.timestamps
    end
  end
end
