class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :long_url, presence: true
      t.string :short_url, index: true

      t.integer :submitter_id, index: true, presence: true
    end
  end
end
