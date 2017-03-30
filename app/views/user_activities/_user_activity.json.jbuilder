json.extract! user_activity, :id, :user_id, :happened_at, :public_details, :private_details, :created_at, :updated_at
json.url user_activity_url(user_activity, format: :json)
