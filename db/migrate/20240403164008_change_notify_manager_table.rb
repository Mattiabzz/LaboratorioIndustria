class ChangeNotifyManagerTable < ActiveRecord::Migration[7.1]
  def change
    remove_reference :notify_managers, :event, index: true, foreign_key: true
    #add_reference :notify_managers, :user, null: false, foreign_key: true
    add_column :notify_managers, :letto, :boolean, default: false
  end
end
