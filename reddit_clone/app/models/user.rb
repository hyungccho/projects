# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_reader :password

  validates :username, :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :ensure_session_token

  has_many :subs,
    class_name: "Sub",
    foreign_key: "moderator_id",
    primary_key: "id"

  has_many :posts,
    class_name: "Post",
    foreign_key: "author_id",
    primary_key: "id"

  has_many :comments,
    class_name: "Comment",
    foreign_key: "author_id",
    primary_key: "id"

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    save!
    session_token
  end

  private

    def ensure_session_token
      self.session_token ||= SecureRandom.urlsafe_base64(16)
    end
end
