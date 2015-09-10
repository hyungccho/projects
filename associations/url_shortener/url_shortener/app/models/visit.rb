class Visit < ActiveRecord::Base
  validates :user_id, presence: true
  validates :url_id, presence: true

  belongs_to :visitor,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id

  belongs_to :visited_url,
    class_name: "ShortenedUrl",
    foreign_key: :url_id,
    primary_key: :id

  def self.record_vist!(user, shortened_url)
    self.new(user_id: user.id, url_id: shortened_url.id)
  end
end
