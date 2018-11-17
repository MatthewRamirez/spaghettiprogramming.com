class UsersController < ApplicationController

  before_action :redirect_to_root_unless_signed_in

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find params[:id]
    @user.update_attributes(user_params) ? redirect_to(root_path) : render(:edit)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :identifier_url, :nick)
  end

end
