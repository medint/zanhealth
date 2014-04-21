json.array!(@bmet_work_requests) do |bmet_work_request|
  json.extract! bmet_work_request, :id, :requester, :department, :location, :phone, :email, :description
  json.url bmet_work_request_url(bmet_work_request, format: :json)
end
