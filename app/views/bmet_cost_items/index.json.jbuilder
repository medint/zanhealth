json.array!(@bmet_cost_items) do |bmet_cost_item|
  json.extract! bmet_cost_item, :id, :name, :facility_id
  json.url bmet_cost_item_url(bmet_cost_item, format: :json)
end
