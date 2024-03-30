json.extract! reservation, :id, :user_id, :event_id, :data_prenotazione, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
