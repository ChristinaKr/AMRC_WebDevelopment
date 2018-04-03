class AddColumnToProject < ActiveRecord::Migration[5.1]
  def up
    add_column :projects, :userID, :integer
  end

  def down
    remove_column :projects, :column
  end
end
