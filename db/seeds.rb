# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.create(nome: 'Mattia', cognome: 'Bozzo', email: 'mattia@utente.com' ,eta: 25, codice_fiscale: 'ABCDEF12G34H56I789A', password: 'password')
User.create(nome: 'Giovanni', cognome: 'Gialli', email: 'giovanni@utente.com' ,eta: 20, codice_fiscale: 'ABCDEF12G34H56I789B', password: 'password')
User.create(nome: 'Vincenzo', cognome:'Verdi', email: 'vincenzo@utente.com' ,eta: 18, codice_fiscale: 'ABCDEF12G34H56I789C', password: 'password')

Manager.create(nome: 'Mattia', cognome: 'Bozzo', email: 'mattia@manager.com', password: 'password')
Manager.create(nome: 'Karim', cognome: 'Bianchi', email: 'karim@manager.com', password: 'password')



# Seed data for events
events_data = [
    {
      nome: "Concerto",
      luogo: "Teatro XYZ",
      data_inizio: DateTime.new(2024, 4, 10, 18, 0, 0),
      descrizione: "Concerto di musica classica",
      capacita: 200,
      capacita_corrente: 0,
      manager_id: 1,
      data_fine: DateTime.new(2024, 4, 10, 20, 0, 0),
      citta: "Roma",
      via: "Via Roma 123"
    },
    {
      nome: "Fiera",
      luogo: "Fiera di Milano",
      data_inizio: DateTime.new(2024, 5, 15, 10, 0, 0),
      descrizione: "Fiera internazionale dell'industria",
      capacita: 500,
      capacita_corrente: 0,
      manager_id: 2,
      data_fine: DateTime.new(2024, 5, 17, 18, 0, 0),
      citta: "Milano",
      via: "Via Fiera 456"
    },
    {
    nome: "Conferenza",
    luogo: "Centro Congressi",
    data_inizio: DateTime.new(2024, 6, 20, 9, 0, 0),
    descrizione: "Conferenza sull'innovazione tecnologica",
    capacita: 150,
    capacita_corrente: 0,
    manager_id: 2,
    data_fine: DateTime.new(2024, 6, 21, 17, 0, 0),
    citta: "Firenze",
    via: "Via Firenze 789"
  },
  {
    nome: "Evento di tre giorni",
    luogo: "Centro congressi",
    data_inizio: DateTime.new(2024, 5, 17, 9, 0, 0),
    descrizione: "Evento che si svolge per tre giorni consecutivi",
    capacita: 300,
    capacita_corrente: 0,
    manager_id: 1,
    data_fine: DateTime.new(2024, 5, 19, 17, 0, 0),
    citta: "Napoli",
    via: "Via Napoli 321"
  },
  {
    nome: "Evento Intimo",
    luogo: "Casa",
    data_inizio: DateTime.new(2024, 7, 5, 18, 0, 0),
    descrizione: "Una serata intima per pochi ospiti",
    capacita: 1,
    capacita_corrente: 0, 
    manager_id: 1,
    data_fine: DateTime.new(2024, 7, 5, 19, 0, 0),
    citta: "Torino",
    via: "Via Torino 101"
  },
  {
    nome: "Seminario",
    luogo: "Università di Bologna",
    data_inizio: DateTime.new(2024, 8, 15, 10, 0, 0),
    descrizione: "Seminario sull'innovazione nel settore tecnologico",
    capacita: 100,
    capacita_corrente: 0, 
    manager_id: 2, 
    data_fine: DateTime.new(2024, 8, 16, 17, 0, 0),
    citta: "Bologna",
    via: "Via Università 123"
  }
  ]
  # Add more event data here as needed






 events_data.each do |event_data|
     Event.create!(event_data)
 end