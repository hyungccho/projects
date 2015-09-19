class ChangeUniqueOnBandId < ActiveRecord::Migration
  def change
    remove_column :albums, :band_id
    add_column :albums, :band_id, :integer
    add_index :albums, :band_id
  end
end
