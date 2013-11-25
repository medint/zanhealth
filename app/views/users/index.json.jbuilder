json.array!(@users) do |user|
  json.extract! user, :username, :encrypted_password, :role_id, :created, :modified, :telephone_num
  json.url user_url(user, format: :json)
end
