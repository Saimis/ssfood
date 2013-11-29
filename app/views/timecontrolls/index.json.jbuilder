json.array!(@timecontrolls) do |timecontroll|
  json.extract! timecontroll, :start, :end, :gap
  json.url timecontroll_url(timecontroll, format: :json)
end
