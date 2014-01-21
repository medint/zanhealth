json.array!(@items) do |item|
  json.extract! item, :asset_id, :model_id, :serial_number, :year_manufactured, :funding, :date_received, :warranty_expire, :contract_expire, :warranty_notes, :service_agent, :department_id, :item_type, :price
  json.url item_url(item, format: :json)
end
