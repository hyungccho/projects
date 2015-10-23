class Bench < ActiveRecord::Base
  validates :lat, :long, :description, presence: true

  has_many :reviews

  def self.filter(params)
    benches = Bench.where("lat > ? AND lat < ? AND long > ? AND long < ?",
                          params["bounds"]["southWest"]["lat"], params["bounds"]["northEast"]["lat"],
                          params["bounds"]["southWest"]["long"], params["bounds"]["northEast"]["long"])

    benches = benches.where("seating < ?", params["maxSeats"]) if params["maxSeats"]
    benches = benches.where("seating > ?", params["minSeats"]) if params["minSeats"]

    benches
  end
end
