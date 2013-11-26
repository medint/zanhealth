json.array!(@texts) do |text|
  json.extract! text, :content, :number, :work_request_id
  json.url text_url(text, format: :json)
end
