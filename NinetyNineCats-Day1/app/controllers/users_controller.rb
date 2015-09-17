class UsersController < ApplicationController

  before_action :check_status

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_name: params[:user][:user_name])
    @user.password = params[:user][:password]
    if @user.save
      login_user!(@user)
    else
      render :new
      # flash some shit
    end
  end

  def check_status
    redirect_to cats_url if current_user
  end

  private
    def user_params
      params.require(:user).permit(:user_name, :password_digest)
    end
end
