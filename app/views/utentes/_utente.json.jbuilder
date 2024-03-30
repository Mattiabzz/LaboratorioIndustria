json.extract! utente, :id, :nome, :cognome, :eta, :email, :codice_fiscale, :text, :created_at, :updated_at
json.url utente_url(utente, format: :json)
