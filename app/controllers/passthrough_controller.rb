class PassthroughController < ApplicationController

  # ascertains whether user is charity or admin and sets redirect to correspond
  # to ladning page for charity and dashboard for admin
  def index
      path = case current_user.charity_role
      when true
          # 'amrc_dashboard/dashboard'
          {:controller => 'charity_lp', :action => 'landingpage'}
        when false
          # 'charity_lp/landingpage'
          {:controller => 'amrc_dashboard', :action => 'dashboard'}
        else
          # 'grant_upload/grant_data'
          # {:controller => 'amrc_dashboard', :action => 'dashboard'}
      end

      redirect_to path
    end

end
