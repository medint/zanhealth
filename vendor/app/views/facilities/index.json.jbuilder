json.array!(@facilities) do |facility|
  json.extract! facility, :name
  json.url facility_url(facility, format: :json)
end
