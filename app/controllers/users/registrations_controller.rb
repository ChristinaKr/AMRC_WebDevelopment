class Users::RegistrationsController < Devise::RegistrationsController

  skip_before_action :require_no_authentication

layout 'sign_up_layout'
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    build_resource(project_params)
    if resource.save
      flash[:notice] = "'#{resource.charity_name}' Succesfully Added"
        redirect_to "/users/sign_up"
    else
      render 'new'
    end
  end

  def findID
    @user = User.new
    @user = session[:current_user_id]
  end

  def index
    @users = User.all
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  def after_sign_up_path_for(resource)
    charity_lp_landingpage_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

    def project_params
      params.require(:user).permit(:charity_name, :resexp_contact_name, :resexp_contact_email, :grants_contact_name, :grants_contact_email, :submission_status_resexp, :submission_status_grants, :category, :username, :password, :email, :password_confirmation)
    end

end
