class Team < ActiveRecord::Base
  validates :code, :full_name, presence: true

  has_many :players,
    class_name: "Player",
    foreign_key: "team",
    primary_key: "code"
end
