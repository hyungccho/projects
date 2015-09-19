class Note < ActiveRecord::Base
  validates :user_id, :track_id, :note_text, presence: true

  belongs_to :track,
    class_name: "Track",
    foreign_key: "track_id",
    primary_key: "id"
end
