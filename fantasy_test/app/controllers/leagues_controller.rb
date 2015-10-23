class LeaguesController < ApplicationController
  def index
    @leagues = League.all
    render :index
  end

  def new
    render :new
  end

  def create
    @league = League.new(league_params)
    @league.moderator_id = params[:user_id]

    if @league.save
      UserMembership.create!(user_id: params[:user_id], league_id: @league.id)
      redirect_to user_url(params[:user_id])
    else
      flash.now[:errors] = @league.errors.full_messages
      render :new
    end
  end

  def show
    @league = League.includes(:users).find(params[:id])
    @draft = @league.draft
    @teams = Team.all

    render :show
  end

  def player
    @user = User.find_by(id: params[:user_id])
    @players = @user.players.where(user_id: params[:id])
  end

  def available_players
    @league = League.find(params[:id])
    @available_players = @league.available_players(params[:pos])
    @count = @available_players.count
  end

  private

  def league_params
    params.require(:league).permit(:name)
  end
end
