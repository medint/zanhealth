json.array!(@facility_costs) do |facility_cost|
  json.extract! facility_cost, :id, :name, :unit_quantity, :cost, :facility_work_order_id
  json.url facility_cost_url(facility_cost, format: :json)
end
