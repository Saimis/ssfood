json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :id, :name, :about, :phone
  json.url restaurant_url(restaurant, format: :json)
end
