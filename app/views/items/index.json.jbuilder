json.array!(@items) do |item|
  json.extract! item, :domain, :tag, :category, :serial_number, :year_manufactured, :funding, :date_received, :warranty_expire, :contract_expire, :warranty_notes, :service_agent, :item_type, :price
  json.url item_url(item, format: :json)
end
