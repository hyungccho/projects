class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.integer :week_id, null: false
      t.integer :player_id, null: false
      t.integer :points, null: false

      t.timestamps null: false
    end
    add_index :rankings, :week_id
    add_index :rankings, :player_id
  end
end
