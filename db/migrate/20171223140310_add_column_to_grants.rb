class AddColumnToGrants < ActiveRecord::Migration[5.1]
  def up
    add_column :grant_data, :userID, :integer
  end

  def down
    remove_column :grant_data, :column
  end
end
