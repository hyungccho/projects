class CreateDrafts < ActiveRecord::Migration
  def change
    create_table :drafts do |t|
      t.integer :league_id, null: false
      t.boolean :finished, default: false, null: false

      t.timestamps null: false
    end

    add_index :drafts, :league_id
  end
end
