class ChangeNotifyUserTable < ActiveRecord::Migration[7.1]
  def change
    remove_reference :notify_users, :event, index: true, foreign_key: true
    #add_reference :notify_users, :user, null: false, foreign_key: true
    add_column :notify_users, :letto, :boolean, default: false
  end
end
