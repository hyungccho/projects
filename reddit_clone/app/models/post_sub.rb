# == Schema Information
#
# Table name: post_subs
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer
#  sub_id     :integer
#

class PostSub < ActiveRecord::Base
  validates :sub, :post, presence: true
  validates :sub_id, uniqueness: { scope: :post_id }

  belongs_to :post,
    class_name: "Post",
    foreign_key: "post_id",
    primary_key: "id"

  belongs_to :sub,
    class_name: "Sub",
    foreign_key: "sub_id",
    primary_key: "id"
end
