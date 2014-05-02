json.array!(@bmet_models) do |bmet_model|
  json.extract! bmet_model, :id, :model_name, :manufacturer_name, :vendor_name, :category
  json.url bmet_model_url(bmet_model, format: :json)
end
