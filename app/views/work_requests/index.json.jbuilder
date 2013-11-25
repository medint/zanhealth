json.array!(@work_requests) do |work_request|
  json.extract! work_request, :date_requested, :date_expire, :date_completed, :request_type, :item, :cost, :description, :status, :owner_id, :requester_id, :cause_description, :action_taken, :prevention_taken
  json.url work_request_url(work_request, format: :json)
end
