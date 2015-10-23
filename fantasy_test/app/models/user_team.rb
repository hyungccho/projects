class UserTeam < ActiveRecord::Base
  validates :league_id, :wins, :losses, presence: true
end
