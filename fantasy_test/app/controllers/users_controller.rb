class UsersController < ApplicationController
  before_action :ensure_logged_in, only: [:new]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      log_in!(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.includes(:user_memberships).find(params[:id])

    render :show
  end

  private

    def user_params
      params.require(:user).permit(:username, :password)
    end

    def ensure_logged_in
      redirect_to user_url(current_user) if current_user
    end
end
