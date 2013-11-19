json.array!(@models) do |model|
  json.extract! model, :manufacturer_name, :vendor_name
  json.url model_url(model, format: :json)
end
