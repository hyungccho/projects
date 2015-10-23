class AddActiveToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :status, :boolean, default: false
  end
end
