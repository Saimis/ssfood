json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :name, :about, :votes, :waslast, :lastused
  json.url restaurant_url(restaurant, format: :json)
end
