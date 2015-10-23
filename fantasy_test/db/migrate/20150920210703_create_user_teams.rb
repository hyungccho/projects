class CreateUserTeams < ActiveRecord::Migration
  def change
    create_table :user_teams do |t|
      t.integer :league_id, null: false
      t.integer :wins, null: false, default: 0
      t.integer :losses, null: false, default: 0

      t.timestamps null: false
    end

    add_index :user_teams, :league_id
  end
end
