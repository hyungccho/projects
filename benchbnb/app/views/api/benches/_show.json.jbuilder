json.extract! bench, :id, :lat, :long, :description

json.reviews do
  json.partial! "reviews_index", reviews: bench.reviews
end
