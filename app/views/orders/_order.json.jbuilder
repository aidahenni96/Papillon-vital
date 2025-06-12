json.extract! order, :id, :user_id, :status, :total_price, :created_at, :updated_at
json.url order_url(order, format: :json)
