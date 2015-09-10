class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :user_id, index: true
      t.integer :url_id, index: true

      t.timestamp
    end
  end
end
