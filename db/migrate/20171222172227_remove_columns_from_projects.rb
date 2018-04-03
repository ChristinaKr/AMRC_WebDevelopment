class RemoveColumnsFromProjects < ActiveRecord::Migration[5.1]
  def up
    remove_column "projects", "total_charitable_activities"
    remove_column "projects", "estimated_spending_on_medical_research_year"
  end

  def down
    add_column "projects", "estimated_spending_on_medical_research_year", :string
    add_column "projects", "total_charitable_activities", :string
  end
end
