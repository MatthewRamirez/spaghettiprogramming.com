module SessionHelper

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.token]
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def signed_in?
    !current_user.nil?
  end

  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page."
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def sign_out
    cookies.delete(:remember_token)
    current_user = nil
    reset_session
  end

  def authenticate
    deny_access unless signed_in?
  end

  private
    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end

    def store_location
      session[:return_to] = request.fullpath
    end

    def clear_return_to
      session[:return_to] = nil
    end
end
