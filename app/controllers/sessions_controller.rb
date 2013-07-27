class SessionsController < ApplicationController

  def new
    @title = "Sign in"
    if signed_in?
      redirect_to(root_path, :notice => "Signed in already!")
    end
  end

  def create
    reset_session
    user = User.find_by_email(params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to root_path, :notice => "Signed in!"
    else
      flash.now.alert = "Invalid login credentials"
      render :new
    end
  end

  def destroy
    sign_out
    reset_session
    redirect_to root_path, :notice => "Signed out!"
  end

end
