class CambioEventi < ActiveRecord::Migration[7.1]
  def change
    rename_column :events, :data, :data_inizio
    add_column :events, :data_fine,:datetime
    add_column :events, :citta,:string
    add_column :events, :via,:string
  end
end
