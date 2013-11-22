json.array!(@work_requests) do |work_request|
  json.extract! work_request, :date_requested, :date_expire, :date_completed, :request_type, :cost, :description, :status, :requester_id
  json.url work_request_url(work_request, format: :json)
end
