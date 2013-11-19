json.array!(@roles) do |role|
  json.extract! role, :name
  json.url role_url(role, format: :json)
end
