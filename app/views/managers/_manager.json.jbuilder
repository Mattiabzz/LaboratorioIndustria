json.extract! manager, :id, :nome, :cognome, :email, :created_at, :updated_at
json.url manager_url(manager, format: :json)
