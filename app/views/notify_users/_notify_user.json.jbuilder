json.extract! notify_user, :id, :tipo, :user_id, :event_id, :created_at, :updated_at
json.url notify_user_url(notify_user, format: :json)
