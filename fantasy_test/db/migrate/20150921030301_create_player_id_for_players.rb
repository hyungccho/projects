class CreatePlayerIdForPlayers < ActiveRecord::Migration
  def change
    add_column :players, :player_id, :integer
    add_index :players, :player_id, unique: true
  end
end
