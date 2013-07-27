class UsersController < ApplicationController

  before_filter :redirect_to_root_unless_signed_in

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes(params[:user])
      redirect_to root_path
    else
      render :edit
    end
  end

end
