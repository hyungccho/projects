class EditPointsToFloat < ActiveRecord::Migration
  def change
    remove_column :rankings, :points
    add_column :rankings, :points, :float
  end
end
