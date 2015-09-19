class Track < ActiveRecord::Base
  TRACK_TYPE = ["Bonus", "Regular"]

  validates :album_id, :title, presence: true
  validates :track_type, inclusion: { in: TRACK_TYPE }

  belongs_to :album,
    class_name: "Album",
    foreign_key: "album_id",
    primary_key: "id"

  has_one :band,
    through: :album,
    source: :band

  has_many :notes,
    class_name: "Note",
    foreign_key: "track_id",
    primary_key: "id"
end
