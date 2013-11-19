json.array!(@users) do |user|
  json.extract! user, :username, :password, :created, :modified, :telephone_num
  json.url user_url(user, format: :json)
end
