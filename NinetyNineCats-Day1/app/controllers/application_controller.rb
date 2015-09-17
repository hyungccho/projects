class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login_user!(user)
    token = user.reset_session_token!
    session[:session_token] = token

    redirect_to cats_url
  end

  helper_method :current_user

end
