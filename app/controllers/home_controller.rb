class HomeController < ApplicationController
  # skip_before_action :authenticate_user!
  # layout 'charity_member_template'
  #
  def index
  #  @project = Project.new
  end
  #
  # def create
  #   @project = Project.new(
  #     project_params.merge(
  #       estimated_spending_on_medical_research_year: 2017
  #     )
  #   )
  #   if @project.save
  #     redirect_to project_path(@project)
  #   else
  #     render :index
  #   end
  # end
  #
  # private
  #
  # def project_params
  #   params.require(:project).permit(:charity_name, :research_spending, :financial_year, :audited_account, :spending_research_overseas, :spending_uk_capital_projects, :spending_overseas_capital_projects, :spending_brief_of_capital_projects, :spending_other_non_medical_research_charitable_activities, :total_charitable_activities, :total_charitable_expenditure, :estimated_spending_on_medical_research, :estimated_spending_on_medical_research_year, :use_of_data_approve_graphs, :use_of_data_share_aggreement, :approval_name, :approval_job_title, :approval_description, :contact_name, :contact_email, :contact_description)
  # end
end
