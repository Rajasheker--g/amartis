class RegistrationsController < Devise::RegistrationsController

  def edit_user
    @user = User.find(params[:id])
  end

  def create
    super
    @user.add_role params[:roles].to_sym
  end

  def update
    super
    @user.remove_role :admin
    @user.add_role params[:roles].to_sym
  end

  def index
  	@users = User.all
  end

  def new_user
  	reset_session
  	redirect_to new_registration_path(resource_name)
  end
end 