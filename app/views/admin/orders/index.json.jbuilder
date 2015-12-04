json.array!(@orders) do |order|
  json.extract! order, :id, :date, :restaurant_id, :caller, :payer, :gc
  json.url order_url(order, format: :json)
end
