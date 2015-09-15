class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :owner_id, null: false
    end

    add_index :groups, :owner_id, unique: true
  end
end
