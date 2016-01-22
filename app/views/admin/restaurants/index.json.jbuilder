json.array!(@restaurants) do |restaurant|
  json.extract! restaurant, :id, :name, :website, :phone
  json.url restaurant_url(restaurant, format: :json)
end
