json.array!(@locations) do |location|
  json.extract! location, :room, :floor, :building, :facilities_id
  json.url location_url(location, format: :json)
end
