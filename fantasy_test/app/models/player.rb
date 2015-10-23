class Player < ActiveRecord::Base
  validates :active, :jersey, :lname, :fname, :team, :position, :dob, presence: true

  belongs_to :organization,
    class_name: "Team",
    foreign_key: "team",
    primary_key: "code"

  has_many :rankings,
    class_name: "Ranking",
    foreign_key: "player_id",
    primary_key: "id"

  has_many :league_memberships,
    class_name: "LeagueMembership",
    foreign_key: "player_id",
    primary_key: "id"

  has_many :leagues,
    through: :league_memberships,
    source: :league
end
