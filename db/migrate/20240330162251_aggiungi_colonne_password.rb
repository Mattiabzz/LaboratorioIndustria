class AggiungiColonnePassword < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :password,:string
    add_column :managers, :password,:string
  end
end
