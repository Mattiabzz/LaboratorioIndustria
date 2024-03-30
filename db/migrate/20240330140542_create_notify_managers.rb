class CreateNotifyManagers < ActiveRecord::Migration[7.1]
  def change
    create_table :notify_managers do |t|
      t.text :tipo
      t.references :manager, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
