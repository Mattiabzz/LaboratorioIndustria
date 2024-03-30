json.extract! user, :id, :nome, :cognome, :email, :eta, :codice_fiscale, :created_at, :updated_at
json.url user_url(user, format: :json)
