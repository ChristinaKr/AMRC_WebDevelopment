class ChangeResearchColumnToDefault < ActiveRecord::Migration[5.1]
  def up
    change_column(:users, :submission_status_resexp, :boolean, :default => false)
  end

  def down
    change_column(:users, :submission_status_resexp, :boolean)
  end
end
