class UsersController < ApplicationController
  include UsersHelper

  def index
    render json: User.all
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])

    @user.destroy
    render json: @user
  end

  def favorites
    @user = User.find(params[:id])
    @favorited_users = @user.contacts.select { |contact| contact.favorited }
    @favorited_users += @user.contact_shares.select { |contact| contact.favorited }

    render json: @favorited_users
  end
end
