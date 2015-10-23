class CreatePlayersTwo < ActiveRecord::Migration
  def change
    create_table :players, id: false do |t|
      t.primary_key :player_id
      t.integer :active, null: false
      t.integer :jersey, null: false
      t.string :lname, null: false
      t.string :fname, null: false
      t.string :team, null: false
      t.string :position, null: false
      t.string :dob, null: false
      t.string :height
      t.string :weight

      t.timestamps null: false
    end

    add_index :players, :position
    add_index :players, :team
    add_index :players, :active
  end
end
