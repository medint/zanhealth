json.array!(@texts) do |text|
  json.extract! text, :content, :number, :bmet_work_order_id
  json.url text_url(text, format: :json)
end
