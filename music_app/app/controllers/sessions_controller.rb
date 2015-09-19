class SessionsController < ApplicationController
  before_action :ensure_not_logged_in, except: :destroy

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:user][:email], params[:user][:password])

    if user.nil?
      flash.now[:errors] = ["Invalid credentials"]
      render :new
    else
      login_user!(user)
      redirect_to user_url(user)
    end
  end

  def destroy
    log_out!(current_user)
  end

  private

    def ensure_not_logged_in
      redirect_to bands_url if current_user
    end
end
