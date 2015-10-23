class DraftsController < ApplicationController
  def create
    @draft = Draft.new(draft_params)
    @league = League.find(params[:league_id])
    @draft.drafters = @league.users.to_a.map(&:id)
    @draft.save

    @league.start_draft! if @draft.save!

    redirect_to league_url(@draft.league_id)
  end

  private

    def draft_params
      params.permit(:league_id)
    end
end
