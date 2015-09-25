class Comment < ActiveRecord::Base
  validates :content, :post_id, :author_id, presence: true

  belongs_to :post,
    class_name: "Post",
    foreign_key: "post_id",
    primary_key: "id"

  belongs_to :user,
    class_name: "User",
    foreign_key: "author_id",
    primary_key: "id"

  has_many :child_comments,
    class_name: "Comment",
    foreign_key: "parent_id",
    primary_key: "id"

  def top_level_comments
    html = "<li>#{self.user.username}: #{self.content}</li>"
    html += "<li>#{self.child_comments.each { |child| child.top_level_comments}}</li>"

    html.html_safe
  end
end
