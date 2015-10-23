class LeagueMembership < ActiveRecord::Base
  belongs_to :player,
    class_name: "Player",
    foreign_key: "player_id",
    primary_key: "id"

  belongs_to :league,
    class_name: "Player",
    foreign_key: "league_id",
    primary_key: "id"
end
