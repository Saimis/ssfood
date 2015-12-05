json.array!(@orders) do |order|
  json.extract! order, :id, :date, :restaurant_id, :caller_id, :payer_id, :garbage_collector_id
  json.url order_url(order, format: :json)
end
