class DeleteUserIdAndAddModeratorIdToLeague < ActiveRecord::Migration
  def change
    remove_column :leagues, :user_id
    add_column :leagues, :moderator_id, :integer
    add_index :leagues, :moderator_id
  end
end
