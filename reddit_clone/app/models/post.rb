# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  author_id  :integer          not null
#

class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :subs, presence: true

  has_many :subs,
    through: :post_subs,
    source: :sub

  belongs_to :author,
    class_name: "User",
    foreign_key: "author_id",
    primary_key: "id"

  has_many :post_subs,
    class_name: "PostSub",
    foreign_key: "post_id",
    primary_key: "id",
    inverse_of: "post"

  has_many :comments,
    class_name: "Comment",
    foreign_key: "post_id",
    primary_key: "id"
end
