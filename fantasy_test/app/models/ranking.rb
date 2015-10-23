class Ranking < ActiveRecord::Base
  validates :week_id, :player_id, :points, presence: true

  belongs_to :player,
    class_name: "Player",
    foreign_key: "player_id",
    primary_key: "id"

  belongs_to :week,
    class_name: "Week",
    foreign_key: "week_id",
    primary_key: "id"
end
