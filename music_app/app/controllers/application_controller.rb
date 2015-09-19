class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def auth_token
    auth = <<-HTML
      <input
        type='hidden'
        name='authenticity_token'
        value='#{form_authenticity_token}'>
    HTML

    auth.html_safe
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def login_user!(user)
    session[:session_token] = user.reset_session_token!
  end

  def log_out!(user)
    user.reset_session_token!

    redirect_to new_session_url
  end

  def check_login
    redirect_to new_session_url unless current_user
  end

  helper_method :auth_token, :current_user, :login_user!, :log_out!, :check_login
end
