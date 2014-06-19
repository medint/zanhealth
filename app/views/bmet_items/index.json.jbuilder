json.array!(@bmet_items) do |bmet_item|
  json.extract! bmet_item, :id, :model_id, :serial_number, :year_manufactured, :funding, :date_received, :warranty_expire, :contract_expire, :warranty_notes, :service_agent, :department_id, :price, :asset_id, :location, :notes
  json.url bmet_item_url(bmet_item, format: :json)
end
