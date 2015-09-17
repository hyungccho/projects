class SessionsController < ApplicationController

  def create
    user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])

    if user.nil?
      render :new
    else
      login_user!(user)
    end
  end

  def new
    check_status
  end

  def destroy
    current_user.reset_session_token! if current_user
    redirect_to new_session_url
  end

  def check_status
    redirect_to cats_url if current_user
  end
end
