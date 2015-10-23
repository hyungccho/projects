class Week < ActiveRecord::Base
  validates :position, :week_num, presence: true

  has_many :rankings,
    class_name: "Ranking",
    foreign_key: "week_id",
    primary_key: "id"
end
