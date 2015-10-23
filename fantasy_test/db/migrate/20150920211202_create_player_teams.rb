class CreatePlayerTeams < ActiveRecord::Migration
  def change
    create_table :league_memberships do |t|
      t.integer :player_id, null: false
      t.integer :league_id, null: false

      t.timestamps null: false
    end

    add_index :league_memberships, [:player_id, :league_id], unique: true
  end
end
