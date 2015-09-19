class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      Confirmation.confirm_email(@user).deliver_now
      
      if activate
        login_user!(@user)
        redirect_to user_url(@user)
      else
        flash.now[:unconfirmed_email] = ["Confirm your email!"]
        redirect_to new_user_url
      end
    else
      flash.now[:invalid_fields] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @bands = Band.all

    render :show
  end

  def activate
    user = User.find_by(activation_token: params[:user][:activation_token])
    return if user.nil?

    user.status = true
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :activation_token)
    end
end
