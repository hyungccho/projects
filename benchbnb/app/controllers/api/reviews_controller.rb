class Api::ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)

    @review.save
    render json: Bench.find(params[:review][:bench_id])
  end

  private

    def review_params
      params.require(:review).permit(:body, :score, :bench_id)
    end
end
