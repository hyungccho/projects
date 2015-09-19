class ChangeActivationTokenForUsers < ActiveRecord::Migration
  def change
    remove_column :users, :activation_token
    add_column :users, :activation_token, :string, null: false
  end
end
