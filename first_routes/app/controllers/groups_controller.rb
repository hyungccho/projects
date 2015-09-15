class GroupsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    render json: @user.groups
  end
end
