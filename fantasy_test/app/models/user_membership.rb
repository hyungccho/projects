class UserMembership < ActiveRecord::Base
  validates :user_id, :league_id, presence: true
  validates :user_id, presence: { scope: :league_id }

  belongs_to :user,
    class_name: "User",
    foreign_key: "user_id",
    primary_key: "id"

  belongs_to :league,
    class_name: "League",
    foreign_key: "league_id",
    primary_key: "id"
end
