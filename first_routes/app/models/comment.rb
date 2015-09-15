class Comment < ActiveRecord::Base
  validates :commentable_type, :commentable_id, :body, presence: true

  belongs_to :commentable,
    polymorphic: true
end
