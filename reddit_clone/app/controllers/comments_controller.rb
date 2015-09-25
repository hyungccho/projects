class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comments = Post.includes(comments: :user)

    render :new
  end

  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      flash.now[:errors] = ["Something went wrong"]
      render :new
    end
  end

  def show
    @comment = Comment.includes(:user, :post).find(params[:id])

    render :show
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :post_id, :author_id, :parent_id)
    end
end
