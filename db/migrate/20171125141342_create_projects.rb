class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :charity_name
      t.float :research_spending
      t.string :financial_year
      t.boolean :audited_account
      t.string :spending_research_overseas
      t.string :spending_uk_capital_projects
      t.string :spending_overseas_capital_projects
      t.string :spending_brief_of_capital_projects
      t.string :spending_other_non_medical_research_charitable_activities
      t.string :total_charitable_activities
      t.string :total_charitable_expenditure
      t.string :estimated_spending_on_medical_research
      t.string :estimated_spending_on_medical_research_year
      t.boolean :use_of_data_approve_graphs
      t.boolean :use_of_data_share_aggreement
      t.string :approval_name
      t.string :approval_job_title
      t.string :approval_description
      t.string :contact_name
      t.string :contact_email
      t.string :contact_description

      t.timestamps
    end
  end
end
