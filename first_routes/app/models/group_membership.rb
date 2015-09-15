class GroupMembership < ActiveRecord::Base
  validates :group_id, :contactable_id, presence: true

  belongs_to :group,
    class_name: "Group",
    foreign_key: "group_id",
    primary_key: "id"

  belongs_to :contactable,
    polymorphic: true
end
