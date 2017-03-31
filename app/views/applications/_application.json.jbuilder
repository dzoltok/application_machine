json.extract! application, :id, :goal, :user_id, :triage_required?, :created_at, :updated_at
json.url application_url(application, format: :json)
