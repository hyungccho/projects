class SessionsController < ApplicationController
  before_action :ensure_not_logged_in, except: [:destroy]

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by(username: params[:user][:username])
    @user = User.new(user_params)

    if user.nil?
      flash.now[:errors] = ["Invalid username and/or password"]
      render :new
    else
      if user.is_password?(params[:user][:password])
        log_in!(user)
      else
        flash.now[:errors] = ["Invalid username and/or password"]
        render :new
      end
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = SecureRandom.urlsafe_base64

    redirect_to new_session_url
  end

  private

    def ensure_not_logged_in
      redirect_to user_url(current_user) if current_user
    end

    def user_params
      params.require(:user).permit(:username, :password)
    end
end
