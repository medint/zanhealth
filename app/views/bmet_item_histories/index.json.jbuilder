json.array!(@bmet_item_histories) do |bmet_item_history|
  json.extract! bmet_item_history, :id, :bmet_item_id, :bmet_item_status, :bmet_item_condition, :remarks, :work_order, :work_order_status
  json.url bmet_item_history_url(bmet_item_history, format: :json)
end
