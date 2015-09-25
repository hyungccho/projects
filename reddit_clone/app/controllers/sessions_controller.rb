class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_username(params[:user][:username])
    return if user.nil?
    if user.is_password?(params[:user][:password])
      session[:session_token] = user.reset_session_token!
      redirect_to user_url(user)
    else
      render :new
    end
  end

  def destroy
    user = User.find_by(session_token: session[:session_token])
    user.reset_session_token!
    session[:session_token] = SecureRandom.urlsafe_base64(16)
    
    render :new
  end
end
