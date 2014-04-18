json.array!(@facility_work_requests) do |facility_work_request|
  json.extract! facility_work_request, :id, :requester, :department, :location, :phone, :email, :description
  json.url facility_work_request_url(facility_work_request, format: :json)
end
