json.array!(@needs) do |need|
  json.extract! need, :name, :quantity, :urgency, :reason, :remarks, :stage, :date_requested
  json.url need_url(need, format: :json)
end
