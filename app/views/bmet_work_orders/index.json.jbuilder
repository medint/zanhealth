json.array!(@bmet_work_orders) do |bmet_work_order|
  json.extract! bmet_work_order, :date_requested, :date_expire, :date_completed, :request_type, :item, :cost, :description, :status, :owner_id, :requester_id, :cause_description, :action_taken, :prevention_taken
  json.url bmet_work_order_url(bmet_work_order, format: :json)
end
