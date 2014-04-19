json.array!(@facility_labor_hours) do |facility_labor_hour|
  json.extract! facility_labor_hour, :id, :date_started, :duration, :technician_id, :facility_work_order_id, :created_at, :updated_at
  json.url facility_labor_hour_url(facility_labor_hour, format: :json)
end
