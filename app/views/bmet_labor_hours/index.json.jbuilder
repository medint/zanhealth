json.array!(@bmet_labor_hours) do |bmet_labor_hour|
  json.extract! bmet_labor_hour, :id, :date_started, :duration, :technician_id, :bmet_work_order_id
  json.url bmet_labor_hour_url(bmet_labor_hour, format: :json)
end
