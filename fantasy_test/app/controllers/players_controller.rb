class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:player_id])
    @rankings = Ranking.includes(:week).where(player_id: params[:player_id])
    @league = League.where(id: params[:league_id])

    @draft = @league.draft unless @league.empty?

    render :show
  end
end
