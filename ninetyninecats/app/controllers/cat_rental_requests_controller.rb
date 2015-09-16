class CatRentalRequestsController < ApplicationController
  def index
    @cat = Cat.find(params[:cat_id])
  end

  def show
    @request = CatRentalRequest.find(params[:id])
  end

  def new
    @cats = Cat.all
  end

  def create
    @rental_request = CatRentalRequest.new(request_params)

    if @rental_request.save
      redirect_to cat_rental_request_url(@rental_request)
    else
      render :new
    end
  end

  def approve
    @request = CatRentalRequest.find(params[:cat_rental_request_id])
    @request.approve!

    redirect_to cat_url(@request.cat_id)
  end

  def deny
    @request = CatRentalRequest.find(params[:cat_rental_request_id])

    @request.deny!

    redirect_to cat_url(@request.cat_id)
  end

  private
    def request_params
      params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
    end
end
