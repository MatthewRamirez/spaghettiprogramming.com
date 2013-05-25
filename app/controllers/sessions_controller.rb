class SessionsController < ApplicationController
  def new
    @title = "Sign in"
    signed_in? ? redirect_to(root_path, :notice => "Signed in already!") : redirect_to('/auth/google_oauth2')
  end

  def create
    reset_session
    session[:auth] = request.env["omniauth.auth"]
    user_params = {
      :uid => session[:auth]['extra']['raw_info']['id'],
      :nick => session[:auth]['extra']['raw_info']['name'],
      :email_address => session[:auth]['extra']['raw_info']['email'],
      :identifier_url => session[:auth]['extra']['raw_info']['link'],
      :provider => session[:auth]['provider']
    }
    redirect_to root_path and return unless APP_CONFIG["VALID_ADMINISTRATOR_EMAILS"].has_key? user_params[:email_address]
    user = User.find_by_uid(session[:auth]['extra']['raw_info']['id']) || User.create_from_auth(user_params)

    session[:user_id] = user.id
    redirect_to root_path, :notice => "Signed in!"
  end

  def destroy
    sign_out
    reset_session
    redirect_to root_path, :notice => "Signed out!"
  end

end
