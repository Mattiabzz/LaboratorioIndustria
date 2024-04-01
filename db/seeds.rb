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

