json.array!(@bmet_costs) do |bmet_cost|
  json.extract! bmet_cost, :id, :name, :unit_quantity, :cost, :created_at, :updated_at, :bmet_work_order_id, :work_request_id
  json.url bmet_cost_url(bmet_cost, format: :json)
end
