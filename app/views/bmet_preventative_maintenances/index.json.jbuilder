json.array!(@bmet_preventative_maintenances) do |bmet_preventative_maintenance|
  json.extract! bmet_preventative_maintenance, :id, :late_date_checked, :days, :weeks, :months, :next_date, :description
  json.url bmet_preventative_maintenance_url(bmet_preventative_maintenance, format: :json)
end
