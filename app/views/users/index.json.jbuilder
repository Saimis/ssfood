json.array!(@users) do |user|
  json.extract! user, :name, :ip, :voted, :food, :decided
  json.url user_url(user, format: :json)
end
