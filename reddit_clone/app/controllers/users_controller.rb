class UsersController < ApplicationController
  before_action :check_login, only: [:show]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in_user!
    else
      flash.now[:errors] = "Invalid username / password combo"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @subs = Sub.all

    render :show
  end

  private
    def user_params
      params.require(:user).permit(:username, :password)
    end

    def check_login
      @user = User.find(params[:id])
      redirect_to user_url(current_user) unless @user == current_user
    end
end
