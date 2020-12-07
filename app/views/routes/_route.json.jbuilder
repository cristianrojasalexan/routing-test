json.extract! route, :id, :starts_at, :ends_at, :load_type, :load_sum, :cities, :stops_amount, :created_at, :updated_at
json.url route_url(route, format: :json)
