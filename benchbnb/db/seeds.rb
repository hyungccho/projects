# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

benches = Bench.create([
  { lat: 37.779346, long: -122.413038, description: "Homy Bench in the heart of SF", seating: 10},
  { lat: 37.787622, long: -122.408317, description: "Dirty Bench Cheap", seating: 2},
  { lat: 37.777243, long: -122.399615, description: "Bench open for daytime", seating: 5},
  { lat: 37.795968, long: -122.421889, description: "Large bench for rent", seating: 6},
  { lat: 37.792195, long: -122.436164, description: "New and clean bench", seating: 15},
  { lat: 37.784688, long: -122.434620, description: "HacknBench #1", seating: 1}
  ])
