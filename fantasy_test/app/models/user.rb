class User < ActiveRecord::Base
  attr_reader :password

  validates :username, :session_token, presence: true, uniqueness: true
  validates :password, length: { minimum: 8, allow_nil: true}

  after_initialize :ensure_session_token

  has_many :user_memberships,
    class_name: "UserMembership",
    foreign_key: "user_id",
    primary_key: "id"

  has_many :participating_leagues,
    through: :user_memberships,
    source: :league

  has_many :players,
    class_name: "LeagueMembership",
    foreign_key: "user_id",
    primary_key: "id"

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    save!
    session_token
  end

  def drafted_players(league)
    Player.joins("JOIN league_memberships ON players.player_id = league_memberships.player_id")
          .joins("JOIN leagues ON league_memberships.league_id = leagues.id")
          .joins("JOIN user_memberships ON leagues.id = user_memberships.league_id")
          .joins("JOIN users ON user_memberships.user_id = users.id")
          .where("leagues.id = #{league.id} AND users.id = #{self.id}")
  end

  private

    def ensure_session_token
      self.session_token ||= SecureRandom.urlsafe_base64
    end
end
