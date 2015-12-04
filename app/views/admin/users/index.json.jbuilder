json.array!(@users) do |user|
  json.extract! user, :id, :name, :lastname, :disabled, :food, :sum
  json.url user_url(user, format: :json)
end
