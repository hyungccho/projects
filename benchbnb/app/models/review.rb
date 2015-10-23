class Review < ActiveRecord::Base
  validates :body, :bench_id, :score, presence: true

  belongs_to :bench
end 
