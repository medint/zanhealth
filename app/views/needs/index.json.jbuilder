json.array!(@needs) do |need|
  json.extract! need, :name, :location_id, :model_id, :quantity, :urgency, :reason, :remarks, :stage, :date_requested, :user_id
  json.url need_url(need, format: :json)
end
