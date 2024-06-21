class DropUtentes < ActiveRecord::Migration[7.1]
  def change
    drop_table :utentes
  end
end
