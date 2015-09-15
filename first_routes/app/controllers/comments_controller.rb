class CommentsController < ApplicationController
  def index

    @comments = find_commentable
    render json: @comments.comments
  end

  def destroy
  end

  private
  def find_commentable
    params.each do |k,v|
      if k =~ /(.+)_id$/
        return $1.classify.constantize.find(v)
      end
    end
    nil
  end

end
