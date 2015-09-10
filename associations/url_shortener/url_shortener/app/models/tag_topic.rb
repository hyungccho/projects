class TagTopic < ActiveRecord::Base
  validates :topic, presence: true, uniqueness: true

  has_many :taggings,
    class_name: "Tagging",
    foreign_key: :topic_id,
    primary_key: :id

  has_many :urls,
    through: :taggings,
    source: :url

  def self.most_popular_links
    TagTopic.select('tagtopics.topic', 'shortened_urls.short_url').joins(:taggings).joins(:taggings).joins(:visited_url).group('shortenedurls.id, tagtopics.topic').order(tagtopics.topic, COUNT(visits.id))
  end

  def most_popular_links

  end

  SELECT
    tagtopics.topic, shortened_urls.short_url
  FROM
    tagtopics
  JOIN
    taggings ON tagtopics.id = taggings.topic_id
  JOIN
    shortened_urls ON taggings.url_id = shortenedurls.id
  JOIN
    visits ON shortenedurls.id = visits.user_id
  GROUP BY
    shortenedurls.id, tagtopics.topic
  ORDER BY
    tagtopics.topic, COUNT(visits.id)


end
