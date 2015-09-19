class AlbumsController < ApplicationController
  before_action :check_login
  
  def new
    @bands = Band.all
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)

    if @album.save
      redirect_to album_url(@album)
    else
      flash.now[:errors] = ["Something went wrong"]
      render :new
    end
  end

  def edit
    @bands = Band.all
    @album = Album.find(params[:id])

    render :edit
  end

  def show
    @album = Album.find(params[:id])

    render :show
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      redirect_to album_url(@album)
    else
      render :edit
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @band = Band.find(@album.band_id)
    @album.destroy

    redirect_to band_url(@band)
  end

  private

    def album_params
      params.require(:album).permit(:band_id, :album_type, :title)
    end
end
