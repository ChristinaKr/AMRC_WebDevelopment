class UsersController < ApplicationController

def index
  @users = Array.new()
  User.all.each do |u|
    if !u.admin?
      @users.push(u)
    end
  end
end

def new
  @users = User.new
end

# creates new charity
def create
  @users = User.new(params[:users])

  if @users.save
    flash[:notice] = "'#{@users.charity_name}' Succesfully Created"
    redirect_to(users_path)
  else
    render (new)
  end
end

# updates charity information
def update
@users = User.find(params[:id])

if @users.update_attributes(project_params)
  flash[:notice] = "'#{@users.charity_name}' Details Succesfully Updated"
  redirect_to(users_path(@users))
else
  render 'edit'
end
end

def edit
  @users = User.find(params[:id])
end

def delete
  @users = User.find(params[:id])
end

# deletes charity
def destroy

  @users = User.find(params[:id])
  @users.destroy
  if Project.exists?(userID: params[:id])
  Project.where(userID: params[:id]).destroy_all
end
  if GrantsData.exists?(userID: params[:id])
  GrantsData.where(userID: params[:id]).destroy_all
end
  flash[:notice] = "Charity '#{@users.charity_name}' Succesfully Deleted"
  redirect_to users_path(@users)
end



private

  def project_params
    params.require(:user).permit(:charity_name, :resexp_contact_name, :resexp_contact_email, :grants_contact_name, :grants_contact_email, :submission_status_resexp, :submission_status_grants, :category, :username, :password, :email, :user)
  end

end
