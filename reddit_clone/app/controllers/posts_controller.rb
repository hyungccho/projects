class PostsController < ApplicationController
  def new
    @post = Post.new
    @subs = Sub.all
    render :new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = ["Something went wrong."]
      @subs = Sub.all
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = Post.includes(comments: :user)

    render :show
  end

  def edit
    @post = Post.find(params[:id])
    @subs = Sub.all
    render :edit
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      render :edit
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :url, :content, :author_id, sub_ids: [])
    end
end
