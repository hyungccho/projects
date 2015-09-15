class CreateFavoriteColumns < ActiveRecord::Migration
  def change
    add_column :contacts, :favorited, :boolean, default: false
    add_column :contact_shares, :favorited, :boolean, default: false
  end
end
