class League < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :player_memberships,
    class_name: "LeagueMembership",
    foreign_key: "league_id",
    primary_key: "id"

  has_many :players,
    through: :player_memberships,
    source: :player

  has_many :user_memberships,
    class_name: "UserMembership",
    foreign_key: "league_id",
    primary_key: "id"

  has_many :users,
    through: :user_memberships,
    source: :user

  has_one :draft,
    class_name: "Draft",
    foreign_key: "league_id",
    primary_key: "id"

  def activate
    return false if self.users.count != 8
    self.status = true
    self.save!
  end

  def start_draft!
    self.started = true
    self.save!
  end

  def available_players(pos = nil)
    if pos
      Player.joins(
        'LEFT OUTER JOIN
          league_memberships ON players.player_id = league_memberships.player_id')
        .where("players.active = 1 AND league_memberships.player_id IS NULL AND players.position = '#{pos}'")
    else
      Player.joins(
        'LEFT OUTER JOIN
          league_memberships ON players.player_id = league_memberships.player_id')
        .where("players.active = 1 AND league_memberships.player_id IS NULL")
    end
  end
end
