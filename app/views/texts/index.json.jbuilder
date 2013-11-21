json.array!(@texts) do |text|
  json.extract! text, :content, :phone_number
  json.url text_url(text, format: :json)
end
