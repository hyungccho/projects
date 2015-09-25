class RemoveNullFromPostSubs < ActiveRecord::Migration
  def change
    remove_column :post_subs, :post_id
    remove_column :post_subs, :sub_id

    add_column :post_subs, :post_id, :integer
    add_column :post_subs, :sub_id, :integer

    add_index :post_subs, [:post_id, :sub_id], unique: true
  end
end
