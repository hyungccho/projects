class Draft < ActiveRecord::Base
  validates :league_id, presence: true

  belongs_to :league,
    class_name: "League",
    foreign_key: "league_id",
    primary_key: "id"

  has_many :users,
    through: :league,
    source: :users

  def current_drafter
    User.find(self.drafters.first.to_i)
  end

  def next_user!
    self.drafters.rotate!(1)
    self.save
  end
end
