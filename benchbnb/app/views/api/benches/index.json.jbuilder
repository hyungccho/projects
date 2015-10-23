json.array! @benches do |bench|
  json.partial! 'show', bench: bench
end
