require 'bcrypt'

class User < ActiveRecord::Base
  validates :user_name, :session_token, :password_digest, presence: true, uniqueness: true

  before_validation :ensure_session_token

  has_many :cats,
    class_name: "Cat",
    foreign_key: "user_id",
    primary_key: "id"

  has_many :cat_rental_requests
  # after_initialize
  attr_reader :password

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
    self.session_token
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    return if user.nil?

    if user.is_password?(password)
      user
    else
      raise
    end
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end
end
