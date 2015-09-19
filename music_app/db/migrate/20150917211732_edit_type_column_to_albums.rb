class EditTypeColumnToAlbums < ActiveRecord::Migration
  def change
    remove_column :albums, :type
    add_column :albums, :album_type, :string
  end
end
