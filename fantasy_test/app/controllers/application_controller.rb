class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def auth_token
    html = <<-HTML
      <input type="hidden"
             name="authenticity_token"
             value="#{form_authenticity_token}">
    HTML

    html.html_safe
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def log_in!(user)
    session[:session_token] = user.session_token
    redirect_to user_url(user)
  end

  POSITIONS = {"QB" => "Quarterback",
               "WR" => "Wide Receiver",
               "TE" => "Tight End",
               "K" => "Kicker",
               "RB" => "Running Back"}

  helper_method :auth_token, :current_user, :log_in!
end
