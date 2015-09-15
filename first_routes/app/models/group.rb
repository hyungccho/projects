class Group < ActiveRecord::Base
  validates :owner_id, presence: true

  has_many :memberships,
    class_name: "GroupMembership",
    foreign_key: "group_id",
    primary_key: "id"

  belongs_to :user,
    class_name: "User",
    foreign_key: "owner_id",
    primary_key: "id"
end
