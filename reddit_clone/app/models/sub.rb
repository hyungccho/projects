# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  moderator_id :integer
#

class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true

  belongs_to :moderator,
    class_name: "User",
    foreign_key: "moderator_id",
    primary_key: "id"

  has_many :posts,
    through: :post_subs,
    source: :sub

  has_many :post_subs,
    class_name: "PostSub",
    foreign_key: "sub_id",
    primary_key: "id"
end
