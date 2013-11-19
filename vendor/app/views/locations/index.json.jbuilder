json.array!(@locations) do |location|
  json.extract! location, :floor, :building
  json.url location_url(location, format: :json)
end
