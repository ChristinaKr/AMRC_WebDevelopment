class AmrcDashboardController < ApplicationController

  before_action :must_be_admin
  before_action :research_sub_list
  before_action :grants_sub_list
  before_action :set_research_count
  before_action :set_research_count_category
  before_action :set_grant_count
  before_action :set_research_est_count
  before_action :num_charities
  before_action :set_grant_count_category
  before_action :set_count_category_total

  # passes sessions to hash_map for use in 'chatkick' bar chart
  def dashboard
    set_cat_data
    @series_a = {"A" => session[:rex_spending_category_a], "B" => session[:rex_spending_category_b], "C" => session[:rex_spending_category_c], "D" => session[:rex_spending_category_d], "E" => session[:rex_spending_category_e]}
    @series_b = {"A" => (session[:category_a] - session[:rex_spending_category_a]), "B" => (session[:category_b] - session[:rex_spending_category_b]), "C" => (session[:category_c] - session[:rex_spending_category_c]), "D" => (session[:category_d] - session[:rex_spending_category_d]), "E" => (session[:category_e] - session[:rex_spending_category_e])}

    @series_c = {"A" => session[:grant_category_a], "B" => session[:grant_category_b], "C" => session[:grant_category_c], "D" => session[:grant_category_d], "E" => session[:grant_category_e]}
    @series_d = {"A" => (session[:category_a] - session[:grant_category_a]), "B" => (session[:category_b] - session[:grant_category_b]), "C" => (session[:category_c] - session[:grant_category_c]), "D" => (session[:category_d] - session[:grant_category_d]), "E" => (session[:category_e] - session[:grant_category_e])}
  end

  # checks if certain charity exists
  def charities_exist
      exists = false
      User.all.each do |r|
        if User.is_charity(r.id)
          exists = true
          break
        end
      end
      exists
    end
    helper_method :charities_exist
  end
