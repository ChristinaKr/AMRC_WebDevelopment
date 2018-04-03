class AmrcEditController < ApplicationController

  before_action :must_be_admin

  def add_new_charity
  end

  def edit_charity
  end

  def edit_options

  end

  # def delete_all_records
  #   if Project.exists? || GrantsData.exists?
  #   if Project.exists?
  #   Project.destroy_all
  # end
  #   if GrantsData.exists?
  #   GrantsData.destroy_all
  # end
  #   flash[:status] = "All Data Deleted"
  # else
  #   flash[:danger] = "No Data in tables"
  # end
  # redirect_to :controller=> 'amrc_edit' :action => 'edit_options'
  # end


end
