class AddActivationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :status, :boolean, default: false
  end
end
