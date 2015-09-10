class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :topic_id
      t.integer :url_id

      t.timestamps
    end
  end

  add_column :shortened_urls, :created_at, :datetime
  add_column :shortened_urls, :updated_at, :datetime
end
