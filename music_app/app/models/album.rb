class Album < ActiveRecord::Base
  ALBUM_TYPE = ["Live", "Studio"]

  validates :band_id, :title, presence: true
  validates :album_type, presence: true, inclusion: { in: ALBUM_TYPE }

  belongs_to :band,
    class_name: "Band",
    foreign_key: "band_id",
    primary_key: "id"

  has_many :tracks,
    class_name: "Track",
    foreign_key: "album_id",
    primary_key: "id",
    dependent: :destroy
end
