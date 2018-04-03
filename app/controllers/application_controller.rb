class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!


  protected

  def after_sign_in_path_for(resource)
    oauth_or_stored_path(resource) || role_path(resource)
  end

  def role_path(resource)
    if resource.admin?
      amrc_dashboard_dashboard_path
    else
      charity_lp_landingpage_path
    end
  end

  # request.env ominiauth is for google / facebook / twitter authentication
  # stored_location accesses the session
  def oauth_or_stored_path(resource)
    request.env['omniauth.origin'] || stored_location_for(resource)
  end

  def authenticate_user!
    session[:user_return_to] = request.env['PATH_INFO']
    super
  end

  #Delete?
  # def set_flash
  #   flash[:notice] = 'Research Expenditure Table Empty'
  #   redirect_to :controller => 'amrc_reports', :action => 'reports'
  # end

  def must_be_admin
    unless current_user && current_user.admin?
      redirect_to root_path, notice: "Restricted page - sorry"
    end
  end
end

# returns message if research form is empty
def set_research_message
  if (Project.find_by userID: current_user.id).present?
  otherproject = Project.find_by userID: current_user.id
  otherproject.presence_of
else
  "Research Form Empty"
end
end

# ascertains total number of grants entries in table and returns value
def count_grant_entries
    session[:grants_number] = GrantsData.where(userID: current_user.id).count
end

# puts together list of userIDs for research forms marked as complete and
# charities that have had their research form manually set as complete
# deletes duplicate values, removes userIDs that belong to admins and returns
# count of total userIDs (number of charities who have subimitted their research
# forms)
def research_sub_list
  complete = Project.completed_forms.concat User.marked_complete_rex
  complete = complete.uniq

  complete.each do |c|

    if !User.is_charity(c)
      complete = complete - [c]
    end
  end
  session[:research_sub] = complete.count
  complete
end

# puts together list of userIDs for grants entries marked as complete and
# charities that have had their grant form manually set as complete
# deletes duplicate values, removes userIDs that belong to admins and returns
# count of total userIDs (number of charities who have entered their grant data)
def grants_sub_list
  users = GrantsData.has_grants.concat User.marked_complete_grants
  users = users.uniq
  subs = Array.new()
  users.each do |u|
    if User.is_charity(u)
      subs.push(u)
    end
  end
  session[:grants_sub] = subs.count()
  subs
end

# gets list of ids for unsubmitted research forms from research_sub_list, finds
# category of each unsubmitted userID and counts total by category
def set_research_count_category
  countA = 0
  countB = 0
  countC = 0
  countD = 0
  countE = 0

  research_sub_list.each do |r|
      if User.find_category(r) == 'A'
      countA = countA + 1
    elsif User.find_category(r) == 'B'
      countB = countB + 1
    elsif User.find_category(r) == 'C'
      countC = countC + 1
    elsif User.find_category(r) == 'D'
      countD = countD + 1
    elsif User.find_category(r) == 'E'
      countE = countE + 1
    end
  end
  session[:rex_spending_category_a] = countA
  session[:rex_spending_category_b] = countB
  session[:rex_spending_category_c] = countC
  session[:rex_spending_category_d] = countD
  session[:rex_spending_category_e] = countE
end

# gets list of ids for unsubmitted grant entries from grants_sub_list, finds
# category of each unsubmitted userID and counts total by category
def set_grant_count_category
  countA = 0
  countB = 0
  countC = 0
  countD = 0
  countE = 0

  grants_sub_list.each do |r|
      if User.find_category(r) == 'A'
      countA = countA + 1
    elsif User.find_category(r) == 'B'
      countB = countB + 1
    elsif User.find_category(r) == 'C'
      countC = countC + 1
    elsif User.find_category(r) == 'D'
      countD = countD + 1
    elsif User.find_category(r) == 'E'
      countE = countE + 1
    end
  end
  session[:grant_category_a] = countA
  session[:grant_category_b] = countB
  session[:grant_category_c] = countC
  session[:grant_category_d] = countD
  session[:grant_category_e] = countE
end

# gets array of number of charities in database from get_array method
def num_charities
  session[:num_charities] = User.get_array.count()
end

# gets number of charities in databse (returned by the get_array
# method) and counts number of each category each is set as a session
def set_count_category_total
  countA = 0
  countB = 0
  countC = 0
  countD = 0
  countE = 0

  User.get_array.each do |r|
      if User.find_category(r) == 'A'
      countA = countA + 1
    elsif User.find_category(r) == 'B'
      countB = countB + 1
    elsif User.find_category(r) == 'C'
      countC = countC + 1
    elsif User.find_category(r) == 'D'
      countD = countD + 1
    elsif User.find_category(r) == 'E'
      countE = countE + 1
    end
  end
  session[:category_a] = countA
  session[:category_b] = countB
  session[:category_c] = countC
  session[:category_d] = countD
  session[:category_e] = countE
end

# iterates through all research forms and counts research spending of each entry
# then sets session
def set_research_count
  count = 0
  Project.rex_total.each do |r|
    if User.is_charity(r.userID)
      count = count + r.research_spending
    end
  end
  session[:rex_spending] = count
end

# iterates through all research forms and counts estimated research spending of
# each entry then sets session
def set_research_est_count
  count = 0
  Project.rex_est_total.each do |r|
    if User.is_charity(r.userID)
      count = count + r.estimated_spending_on_medical_research.to_i
    end
  end
  session[:rex_est_spending] = count
end

# iterates through all grant forms and counts total award value of each entry
# then sets session
def set_grant_count
  count = 0
  GrantsData.grant_total.each do |r|
    if User.is_charity(r.userID)
      count = count + r.award_value
    end
  end
  session[:grant_total] = count
end


# sets category data for dashboard.  If there are charities for each category
# (for grants and research) the percentage submitted are counted and then
# returned as in the form of usubmitted/total (percentage submitted).
def set_cat_data
     if session[:category_a] != 0
     ar = '(' + ((session[:rex_spending_category_a].to_f / session[:category_a].to_f)*100).to_i.to_s + '%)'
     @a_research =  (session[:rex_spending_category_a].to_s + '/' + session[:category_a].to_s) + ar
     end
    if session[:category_a] != 0
    ag = '(' + ((session[:grant_category_a].to_f / session[:category_a].to_f)*100).to_i.to_s + '%)'
    @a_grant = (session[:grant_category_a].to_s + '/' + session[:category_a].to_s) + ag
    end


    if session[:category_b] != 0
    br = '(' + ((session[:rex_spending_category_b].to_f / session[:category_b].to_f)*100).to_i.to_s + '%)'
    @b_research =  (session[:rex_spending_category_b].to_s + '/' + session[:category_b].to_s) + br
    end
    if session[:category_b] != 0
    bg = '(' + ((session[:grant_category_b].to_f / session[:category_b].to_f)*100).to_i.to_s + '%)'
    @b_grant = (session[:grant_category_b].to_s + '/' + session[:category_b].to_s) + bg
    end

    if session[:category_c] != 0
    cr = '(' + ((session[:rex_spending_category_c].to_f / session[:category_c].to_f)*100).to_i.to_s + '%)'
    @c_research = (session[:rex_spending_category_c].to_s + '/' + session[:category_c].to_s) + cr
    end
    if session[:category_c] != 0
    cg = '(' + ((session[:grant_category_c].to_f / session[:category_c].to_f)*100).to_i.to_s + '%)'
    @c_grant = (session[:grant_category_c].to_s + '/' + session[:category_c].to_s) + cg
    end

    if session[:category_d] != 0
    dr = '(' + ((session[:rex_spending_category_d].to_f / session[:category_d])*100).to_i.to_s + '%)'
    @d_research = (session[:rex_spending_category_d].to_s + '/' + session[:category_d].to_s) + dr
    end
    if session[:category_d] != 0
    dg = '(' + ((session[:grant_category_d].to_f / session[:category_d])*100).to_i.to_s + '%)'
    @d_grant = (session[:grant_category_d].to_s + '/' + session[:category_d].to_s) + dg
    end

    if session[:category_e] != 0
    er = '(' + ((session[:rex_spending_category_e].to_f / session[:category_e].to_f)*100).to_i.to_s + '%)'
    @e_research = (session[:rex_spending_category_e].to_s + '/' + session[:category_e].to_s) + er
    end
    if session[:category_e] != 0
    eg = '(' + ((session[:grant_category_e].to_f / session[:category_e].to_f)*100).to_i.to_s + '%)'
    @e_grant = (session[:grant_category_e].to_s + '/' + session[:category_e].to_s) + eg
    end
end

def set_cat_data_int
     if session[:category_a] != 0
     @a_research_int = ((session[:rex_spending_category_a].to_f / session[:category_a].to_f)*100)
    @a_grant_int = ((session[:grant_category_a].to_f / session[:category_a].to_f)*100)
    end

    if session[:category_b] != 0
    @b_research_int = ((session[:rex_spending_category_b].to_f / session[:category_b].to_f)*100)
    @b_grant_int = ((session[:grant_category_b].to_f / session[:category_b].to_f)*100)
    end

    if session[:category_c] != 0
    @c_research_int = ((session[:rex_spending_category_c].to_f / session[:category_c].to_f)*100)
    @c_grant_int = ((session[:grant_category_c].to_f / session[:category_c].to_f)*100)
    end

    if session[:category_d] != 0
    @d_research_int = ((session[:rex_spending_category_d].to_f / session[:category_d])*100)
    @d_grant_int = ((session[:grant_category_d].to_f / session[:category_d])*100)
    end

    if session[:category_e] != 0
    @e_research_int = ((session[:rex_spending_category_e].to_f / session[:category_e].to_f)*100)
    @e_grant_int = ((session[:grant_category_e].to_f / session[:category_e].to_f)*100)
    end
end
