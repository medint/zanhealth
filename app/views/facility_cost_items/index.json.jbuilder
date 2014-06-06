json.array!(@facility_cost_items) do |facility_cost_item|
  json.extract! facility_cost_item, :id, :name, :facility_id
  json.url facility_cost_item_url(facility_cost_item, format: :json)
end
