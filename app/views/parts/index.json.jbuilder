json.array!(@parts) do |part|
  json.extract! part, :id, :name, :manufacturer, :category, :currentQuantity, :minQuantity, :location, :related, :actions
  json.url part_url(part, format: :json)
end
