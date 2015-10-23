class UserMembershipsController < ApplicationController
  after_action :change_league_status_when_filled
  
  def create
    @user_membership = UserMembership.new(
                        league_id: params[:league_id],
                        user_id: current_user.id)

    @user_membership.save
    flash[:errors] = @user_membership.errors.full_messages
    redirect_to league_url(params[:league_id])
  end

  private

    def change_league_status_when_filled
      @league = League.find(@user_membership.league_id)

      @league.activate if @league.users.count == 8
    end
end
