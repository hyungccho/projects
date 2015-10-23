class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.string :position, null: false
      t.integer :week_num, null: false

      t.timestamps null: false
    end

    add_index :weeks, :position
    add_index :weeks, :week_num
  end
end
