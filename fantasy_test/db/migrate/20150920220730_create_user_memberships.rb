class CreateUserMemberships < ActiveRecord::Migration
  def change
    create_table :user_memberships do |t|
      t.integer :user_id, null: false
      t.integer :league_id, null: false

      t.timestamps null: false
    end

    add_index :user_memberships, [:user_id, :league_id], unique: true
  end
end
