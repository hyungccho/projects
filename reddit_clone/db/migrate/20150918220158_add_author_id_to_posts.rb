class AddAuthorIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :author_id, :integer, null: false
    add_index :posts, :author_id
  end
end
