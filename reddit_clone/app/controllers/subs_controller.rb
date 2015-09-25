class SubsController < ApplicationController

  before_action :ensure_moderator, only: [:edit]

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = ["Something went wrong"]
      render :new
    end
  end

  def show
    @sub = Sub.find(params[:id])
    @posts = @sub.posts
    render :show
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = ["Something went wrong"]
      render :edit
    end
  end

  private

    def sub_params
      params.require(:sub).permit(:title, :description)
    end

    def ensure_moderator
      @sub = Sub.find(params[:id])

      redirect_to user_url(current_user) unless current_user.id == @sub.moderator_id
    end
end
