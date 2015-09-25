class DeleteIndexFromSubs < ActiveRecord::Migration
  def change
    remove_column :subs, :moderator_id
    add_column :subs, :moderator_id, :integer
    add_index :subs, :moderator_id
  end
end
