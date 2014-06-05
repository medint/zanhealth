json.array!(@bmet_item_parts) do |bmet_item_part|
  json.extract! bmet_item_part, :id, :name, :facility_id
  json.url bmet_item_part_url(bmet_item_part, format: :json)
end
