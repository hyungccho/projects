class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :album_id, null: false
      t.string :title, null: false
      t.text :lyrics
    end

    add_index :tracks, :album_id, unique: true
  end
end
