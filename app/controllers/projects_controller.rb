class ProjectsController < ApplicationController
  # before_action :set_project, only: [:show, :edit, :update, :destroy]
  layout 'charity_member_template'
  # GET /projects
  # GET /projects.json

def new_or_edit
end



  # GET /projects/new
  # gets new charity form
  def new
    if Project.where(:userID => current_user.id).blank?
    @project = Project.new
  else
    redirect_to "/projects/edit"
  end
  end

  # GET /projects/1/edit
  # edits charity form
  def edit
    @project = Project.find_by userID: current_user.id
  end

  # POST /projects
  # POST /projects.json
  # creates research form
  def create
    @project = Project.new(project_params)
      if @project.save
        redirect_to "/charity_lp/landingpage", notice: 'Research Form was successfully created.'
      #  format.json { render :show, status: :created, location: @project }
      else
        render 'new'

        # format.html {redirect_to "/projects/new", notice: 'Errors in submition, please ensure all fields are filled in correctly' }
        # format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end


  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  # updates research form
  def update
    @project = Project.find_by userID: current_user.id
    if @project.update_attributes(project_params)
      redirect_to "/charity_lp/landingpage", notice: 'Research Form was successfully updated.'
    else
      render 'edit'
      #redirect_to '/projects/edit', notice: 'Errors in submition, please ensure all fields are filled in correctly'
      # format.json { render json: @project.errors, status: :unprocessable_entity }
    end

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_project
    #   @project = Project.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:charity_name, :research_spending, :financial_year, :audited_account, :spending_research_overseas, :spending_uk_capital_projects, :spending_overseas_capital_projects, :spending_brief_of_capital_projects, :spending_other_non_medical_research_charitable_activities, :total_charitable_activities, :total_charitable_expenditure, :estimated_spending_on_medical_research, :estimated_spending_on_medical_research_year, :use_of_data_approve_graphs, :use_of_data_share_aggreement, :approval_name, :approval_job_title, :approval_description, :contact_name, :contact_email, :contact_description, :userID)
    end
end
