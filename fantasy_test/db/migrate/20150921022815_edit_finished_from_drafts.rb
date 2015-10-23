class EditFinishedFromDrafts < ActiveRecord::Migration
  def change
    remove_column :drafts, :finished
    add_column :drafts, :finished, :boolean, default: false
  end
end
