class Project < ApplicationRecord

  self.table_name = "projects"

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_DATE_REGEX = /\A0[1-9]\/[0-9]*|1[0-2]\/[0-9]*\z/i

  validates_presence_of :charity_name
  validates :research_spending, :spending_research_overseas, :spending_uk_capital_projects, :spending_overseas_capital_projects, :spending_other_non_medical_research_charitable_activities, :total_charitable_expenditure, :estimated_spending_on_medical_research, :estimated_spending_on_medical_research, :numericality => true, :allow_blank => true

  validates :contact_email, format: { with: VALID_EMAIL_REGEX }, :allow_blank => true
  validates :financial_year, format: { with: VALID_DATE_REGEX }, :allow_blank => true



  def presence_of
    if self.charity_name.present? && self.research_spending.present? && self.financial_year.present? && self.audited_account.present? && self.spending_research_overseas.present? && self.spending_uk_capital_projects.present? && self.spending_overseas_capital_projects.present? && self.spending_brief_of_capital_projects.present? && self.spending_other_non_medical_research_charitable_activities.present? && self.total_charitable_expenditure.present? && self.estimated_spending_on_medical_research.present? && self.use_of_data_approve_graphs.present? && self.use_of_data_share_aggreement.present? && self.approval_name.present? && self.approval_job_title.present? && self.approval_description.present? && self.contact_name.present? && self.contact_email.present? && self.contact_description.present? && self.userID.present?
      "Research Form Complete"
    else
      "Empty Fields On Research Form"
    end
  end


  def self.completed_forms
    rows = Array.new()
    self.all.each do |row|
      if row.presence_of == "Research Form Complete"
    rows.push(row.userID)
  end
  end
  rows
  end

  def self.rex_total
    research = Array.new()
     self.all.each do |s|
       if s.research_spending.present?
         another = Project.new
         another.userID = s.userID
         another.research_spending = s.research_spending
         research.push(another)
       end
     end
    research
  end

  def self.rex_total_category
    research = Array.new()
     self.all.each do |s|
       if s.research_spending.present?
         another = Project.new
         another.userID = s.userID
         another.research_spending = s.research_spending
         research.push(another)
       end
     end
    research
  end

  def self.rex_est_total
    research = Array.new()
     self.all.each do |s|
       if s.research_spending.present?
         another = Project.new
         another.userID = s.userID
         another.estimated_spending_on_medical_research = s.estimated_spending_on_medical_research
         research.push(another)
       end
     end
    research
  end

  # method calls query-to-csv methos
  def self.all_csv(options = {})
    query_to_csv(Project.all, options)
  end

  # method for downloading individual research data.  Table is created with headers
  # from database table and populated with rows from database
  def self.particular_csv(charity_name, options = {})
    data = Project.where(userID: charity_name)
    column_names = Project.first.attributes.keys
    CSV.generate(options) do |csv|
      csv << column_names
      data.each do |elem|
        csv << elem.attributes.values_at(*column_names)
      end
    end
  end

  # method for downloading research data.  Table is created with headers from
  # database table and populated with rows from database
  def self.query_to_csv(projects, options)
    attributes = %w{Total_Research_Spending Total_Estimated_Research_Spending Total_Grants_Spending Total_Number_of_Charities Research_Forms_Submitted Grant_Forms_Submitted}
    column_names = projects.first.attributes.keys
    CSV.generate(options) do |csv|
      csv << column_names
      projects.each do |elem|
        csv << elem.attributes.values_at(*column_names)
      end
    end
  end

  def delete_all
      Project.destroy_all
  end


end
