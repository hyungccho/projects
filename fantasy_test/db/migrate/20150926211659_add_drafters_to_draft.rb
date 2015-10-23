class AddDraftersToDraft < ActiveRecord::Migration
  def change
    add_column :drafts, :drafters, :string, array: true, default: '{}';
  end
end
