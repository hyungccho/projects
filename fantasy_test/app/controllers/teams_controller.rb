class TeamsController < ApplicationController
  def index
    @teams = Team.all
    render :index
  end

  def show
    @team = Team.find(params[:id])
    @players = @team.players
    render :show
  end
end
