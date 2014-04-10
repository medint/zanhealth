json.array!(@part_transactions) do |part_transaction|
  json.extract! part_transaction, :id, :change_quantity, :date, :vendor, :price, :part_id
  json.url part_transaction_url(part_transaction, format: :json)
end
