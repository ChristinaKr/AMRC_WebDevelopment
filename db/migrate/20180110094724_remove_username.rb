class RemoveUsername < ActiveRecord::Migration[5.1]
  def up
    remove_column :users, :username
  end
  def down
    add_column :users, :username
  end
end
