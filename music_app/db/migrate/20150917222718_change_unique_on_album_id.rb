class ChangeUniqueOnAlbumId < ActiveRecord::Migration
  def change
    remove_column :tracks, :album_id
    add_column :tracks, :album_id, :integer
    add_index :tracks, :album_id
  end
end
