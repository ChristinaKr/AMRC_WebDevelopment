class CharityLpController < ApplicationController

  layout 'charity_member_template'

    before_action :count_grant_entries
    before_action :set_research_message

  def landingpage
    @message = set_research_message
  end

  def lp_tem
    @message = set_research_message
  end




end
