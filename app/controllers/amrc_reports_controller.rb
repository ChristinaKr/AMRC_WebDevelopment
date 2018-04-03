class AmrcReportsController < ApplicationController

  before_action :must_be_admin

  def reports

  end

  # downloads csv of all research data submitted to users computer
  def get_rex
    if Project.exists?
    @grant_data = Project.all_csv
    respond_to do |format|
      format.html
      format.csv do
        send_data @grant_data, filename: "research_data#{Time.now.to_s(:db)}.csv"
      end
      # format.CSV {render csv: @grant_data.to_csv}
      # format.xls {render text: @grant_data.to_csv(col_sep: "\t")}
    end
  else
    flash[:success] = "Research Expenditure Table is Empty"
    redirect_to :controller => 'amrc_reports', :action => 'reports'
  end
  end

  # downloads csv of all unsubmitted charity information to users computer
  def get_unsubmitted
    @grant_data = User.to_csv_unsubmitted
    respond_to do |format|
      format.html
      format.csv do
        send_data @grant_data, filename: "unsubmitted_charity_data#{Time.now.to_s(:db)}.csv"
      end
      # format.CSV {render csv: @grant_data.to_csv}
      # format.xls {render text: @grant_data.to_csv(col_sep: "\t")}
    end
    end

  # downloads csv of all grant data to users computer
  def get_grant_data
    if GrantsData.exists?
      @grant_data = GrantsData.all_csv
      respond_to do |format|
        format.html
        format.csv do
          send_data @grant_data, filename: "all_grants_data_#{Time.now.to_s(:db)}.csv"
        end
      end
    else
      flash[:notice] = 'Grant Data Table Empty'
      redirect_to :controller => 'amrc_reports', :action => 'reports'
    end
  end


  # downloads csv of all daashboard data to users computer
  def to_csv_dash_data
    @grant_data = dash_data_create
    respond_to do |format|
      format.html
      format.csv do
        send_data @grant_data, filename: "all_dashboard_data#{Time.now.to_s(:db)}.csv"
      end
      # format.CSV {render csv: @grant_data.to_csv}
      # format.xls {render text: @grant_data.to_csv(col_sep: "\t")}
    end
  end

# creates csv file containing two tables, one with Total_Research_Spending,
# Total_Estimated_Research_Spending, Total_Grants_Spending,
# Total_Number_of_Charities, Research_Forms_Submitted and Grant_Forms_Submitted
# and another table containing category data.
def dash_data_create
  set_cat_data

  grants_percent = ((session[:research_sub].to_f / session[:num_charities].to_f) * 100).to_s + '%'
  research_percent = ((session[:grants_sub].to_f / session[:num_charities].to_f) * 100).to_s + '%'

  a_val = Array.new()
  b_val = Array.new()
  c_val = Array.new()
  d_val = Array.new()
  e_val = Array.new()
  values = Array.new()

  a_val.push('a', @a_research, @a_grant)
  b_val.push('b', @b_research, @b_grant)
  c_val.push('c', @c_research, @c_grant)
  d_val.push('d', @d_research, @d_grant)
  e_val.push('e', @e_research, @e_grant)
  values.push(session[:rex_spending], session[:rex_est_spending], session[:grant_total], session[:num_charities], grants_percent, research_percent)
    attributes = %w{Total_Research_Spending Total_Estimated_Research_Spending Total_Grants_Spending Total_Number_of_Charities Research_Forms_Submitted Grant_Forms_Submitted}
    attributes1 = values
    attributes2 = %w{Category Research_Expenditure Grant_Expenditure}
    attributesa = a_val
    attributesb = b_val
    attributesc = c_val
    attributesd = d_val
    attributese = e_val

    CSV.generate(headers: true) do |csv|
      csv << attributes
    csv << attributes1
    csv << attributes2
  csv << attributesa
  csv << attributesb
  csv << attributesc
  csv << attributesd
  csv << attributese
  end
  end

  # downloads csv of research data individual charity to users computer
  def get_individual
    individual = User.find(params[:charity_id])
    if Project.exists?(userID: params[:charity_id])
    csv_data = Project.particular_csv(individual.id)
    respond_to do |format|
      format.html
      format.csv do
        send_data csv_data, filename: "individual_research_expenditure_data#{Time.now.to_s(:db)}.csv"
      end
      # format.CSV {render csv: @grant_data.to_csv}
      # format.xls {render text: @grant_data.to_csv(col_sep: "\t")}
    end
  else
    flash[:notice] = 'No Research Data for ' + individual.charity_name
    redirect_to :controller => 'amrc_reports', :action => 'research_individual'
    end
  end

  # downloads csv of grant data for individual to users computer
  def get_individual_grant
    individual = User.find(params[:charity_id])
    if GrantsData.exists?(userID: params[:charity_id])
    csv_data = GrantsData.particular_csv(individual.id)
    respond_to do |format|
      format.html
      format.csv do
        send_data csv_data, filename: "individual_grants_data#{Time.now.to_s(:db)}.csv"
      end
      # format.CSV {render csv: @grant_data.to_csv}
      # format.xls {render text: @grant_data.to_csv(col_sep: "\t")}
    end
  else
    flash[:notice] = 'No Grant Data for ' + individual.charity_name
    redirect_to :controller => 'amrc_reports', :action => 'grants_individual'
  end
  end

  # passes all Users research_individual page
  def research_individual
    @users = Array.new()
    User.all.each do |u|
      if !u.admin?
        @users.push(u)
      end
    end
  end
  # passes all Users grant_individual page
  def grants_individual
    @users = Array.new()
    User.all.each do |u|
      if !u.admin?
        @users.push(u)
      end
    end
  end




end
