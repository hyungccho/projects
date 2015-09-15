class CreateGroupMemberships < ActiveRecord::Migration
  def change
    create_table :group_memberships do |t|
      t.integer :group_id, null: false
      t.integer :contactable_id, null: false
    end

    add_index :group_memberships, :group_id
    add_index :group_memberships, :contactable_id
  end
end
