json.extract! event, :id, :nome, :luogo, :data, :descrizione, :capacita, :capacita_corrente, :manager_id, :created_at, :updated_at
json.url event_url(event, format: :json)
