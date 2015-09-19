class TracksController < ApplicationController
  before_action :check_login

  def create
    @track = Track.new(track_params)

    if @track.save
      redirect_to track_url(@track)
    else
      flash.now[:errors] = ["Something went wrong"]
      render :new
    end
  end

  def new
    @albums = Album.all
    @track = Track.new

    render :new
  end

  def edit
    @track = Track.find(params[:id])
    @albums = Album.all

    render :edit
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def update
    @track = Track.find(params[:id])

    if @track.update(track_params)
      redirect_to track_url(@track)
    else
      render :edit
    end
  end

  def destroy
  end

  private

    def track_params
      params.require(:track).permit(:album_id, :title, :lyrics, :track_type)
    end
end
