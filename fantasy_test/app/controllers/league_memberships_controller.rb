class LeagueMembershipsController < ApplicationController

  before_action :ensure_available_to_draft

  def create
    @league_membership = LeagueMembership.new(league_mem_params)

    if @league_membership.save
      @league = League.find(@league_membership.league_id)
      @league.draft.next_user!

      redirect_to league_url(@league_membership.league_id)
    else
      flash.now[:errors] = @league_membership.errors.full_messages
      redirect_to player_url(@league_membership.player_id)
    end
  end

  private

    def league_mem_params
      params.permit(:player_id, :league_id)
    end

    def ensure_available_to_draft
      @league = League.find(params[:league_id])

      redirect_to user_url(current_user) if @league.draft.current_drafter != current_user
    end
end
