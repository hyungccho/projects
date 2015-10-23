class AddUserIdToLeagueMemberships < ActiveRecord::Migration
  def change
    add_column :league_memberships, :user_id, :integer
    add_index :league_memberships, :user_id
  end
end
