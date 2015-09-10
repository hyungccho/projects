class ShortenedUrl < ActiveRecord::Base
  validates :long_url, length: { maximum: 1024 }, presence: true, uniqueness: true
  validates :submitter_id, presence: true
  validate :less_than_five_in_a_minute
  validate :premium_user_if_over_five

  belongs_to :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id

  has_many :visitors,
    Proc.new { distinct },
    through: :visits,
    source: :visitor

  has_many :visits,
    class_name: "Visit",
    foreign_key: :url_id,
    primary_key: :id

  has_many :taggings,
    class_name: "Tagging",
    foreign_key: :url_id,
    primary_key: :id

  has_many :tags,
    through: :taggings,
    source: :topic

  def self.random_code
    random_code = SecureRandom.urlsafe_base64(16)
    while ShortenedUrl.exists?(:short_url => random_code)
      random_code = SecureRandom.urlsafe_base64(16)
    end
    random_code
  end

  def self.create_for_user_and_long_user!(user, long_url)
    new_url = ShortenedUrl.create!(long_url: long_url, submitter_id: user.id)
    new_url.short_url = ShortenedUrl.random_code
    new_url.save!
    new_url
  end

  def num_clicks
    Visit.where(url_id: self.id).count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    num_uniques.where(created_at: 10.minutes.ago)
  end

  def self.prune(n)
    good_urls = Visit.select(:url_id).where(created_at: n.minutes.ago..Time.now)
    ShortenedUrl.all.each do |url|
      ShortenedUrl.destroy(url.id) unless good_urls.exists?(url_id: url.id)
    end
  end

  private

  def less_than_five_in_a_minute
    count = ShortenedUrl.where(created_at: 1.minute.ago..Time.now, submitter_id: self.submitter_id).count
    if count > 5
      errors[:less] << "can't submit more than 5 times in one minute"
    end
  end

  def premium_user_if_over_five
    count = ShortenedUrl.where(submitter_id: self.submitter_id).count
    user = User.find_by_id(self.submitter_id)
    if count > 5 && !(user.premium)
      errors[:premium] << "must upgrade account to create more than 5 URLs"
    end
  end
end
