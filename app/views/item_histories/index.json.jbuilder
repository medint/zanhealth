json.array!(@item_histories) do |item_history|
  json.extract! item_history, :item_id, :datetime, :status, :utilization, :remarks
  json.url item_history_url(item_history, format: :json)
end
