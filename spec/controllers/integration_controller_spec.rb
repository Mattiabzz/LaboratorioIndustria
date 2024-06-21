require 'rails_helper'
require 'faker'
# require 'rspec/propcheck'

RSpec.describe "Events", type: :request do
  describe "POST /events" do
    let(:manager) do
      Manager.create!(
        nome: "Mario",
        cognome: "Rossi",
        email: "mario.rossi@example.com",
        password: "password"
      )
    end

    before do
      # Effettua il login del manager
      post '/login', params: { email: manager.email, password: manager.password }
    end

    it "creates an event after manager is authenticated" do
      # Verifica che il manager sia autenticato
      #expect(response).to have_http_status(200)
      10.times do
      # Crea un evento con data di fine successiva alla data di inizio
      data_inizio = Faker::Time.between(from: DateTime.now, to: DateTime.now + 30.days)
      data_fine = data_inizio + Faker::Number.between(from: 1, to: 10).days
      post '/events', params: {
        event: {
          nome: Faker::Lorem.sentence(word_count: 3),
          luogo: Faker::Address.city,
          data_inizio: data_inizio,
          data_fine: data_fine,
          descrizione: Faker::Lorem.paragraph,
          capacita: Faker::Number.between(from: 10, to: 100),
          capacita_corrente: Faker::Number.between(from: 0, to: 10),
          manager_id: Manager.find_by(email: "mario.rossi@example.com"),
          citta: Faker::Address.city,
          via: Faker::Address.street_name
          # Puoi aggiungere altri attributi secondo necessità
        }
      }
      #expect(response).to have_http_status(200)
      #expect(response.body).to include("Event was successfully created.")

      # Verifica che l'evento sia stato creato nel database
      created_event = Event.find_by(manager_id: Manager.find_by(email: "mario.rossi@example.com"))
      expect(created_event.nome).to be_present
      expect(created_event.luogo).to be_present
      expect(created_event.data_inizio).to be_present
      expect(created_event.data_fine).to be_present
      expect(created_event.descrizione).to be_present
      expect(created_event.capacita).to be_present
      expect(created_event.capacita_corrente).to be_present 
      expect(created_event.capacita).to be > 0
      expect(created_event.capacita_corrente).to be >=0
      expect(created_event.manager_id).to be_present
      expect(created_event.citta).to be_present
      expect(created_event.via).to be_present

      # Verifica che la data di fine sia successiva alla data di inizio
      expect(created_event.data_fine).to be > created_event.data_inizio
      end
    end
   
  end #fine parte post

  describe "patch /events" do
    let(:manager) do
        Manager.create!(
          nome: "Mario",
          cognome: "Rossi",
          email: "mario.rossi@example.com",
          password: "password"
        )
      end

    let(:event) do
        Event.create!(
          nome: "Evento da aggiornare",
          luogo: "Luogo di prova",
          data_inizio: DateTime.now,
          data_fine: DateTime.now + 1.day,
          descrizione: "Descrizione dell'evento",
          capacita: 50,
          capacita_corrente: 0,
          manager_id: manager.id,
          citta: "Città di prova",
          via: "Via di prova"
        )
      end

      let(:event2) do
        Event.create!(
          nome: "Evento da aggiornare",
          luogo: "Luogo di prova",
          data_inizio: DateTime.now,
          data_fine: DateTime.now + 1.day,
          descrizione: "Descrizione dell'evento",
          capacita: 10,
          capacita_corrente: 0,
          manager_id: manager.id,
          citta: "Città di prova",
          via: "Via di prova"
        )
      end

      let(:user) do
        User.create!(
          nome: Faker::Name.first_name,
          cognome: Faker::Name.last_name,
          email: Faker::Internet.email,
          eta: Faker::Number.between(from: 18, to: 65),
          codice_fiscale: Faker::Alphanumeric.alpha(number: 16).upcase,
          password: "password"
        )
      end

      let(:reservation) do
        Reservation.create!(
          user_id: user.id,
          event_id: event.id,
          data_prenotazione: DateTime.now
        )
      end

      it "updates an event successfully" do

        post '/login', params: { email: manager.email, password: manager.password }

        10.times do

            new_nome = Faker::Lorem.sentence(word_count: 3)
        
            patch "/events/#{event.id}", params: {
            event: {
                nome: new_nome
            }
        }
        
            # Verifica che l'evento nel database sia stato aggiornato correttamente
            updated_event = Event.find(event.id)
            expect(updated_event.nome).to eq(new_nome)
            # Verifica altri attributi aggiornati se necessario

        end
      end#fine it di update

      it "check notify user" do

        
        post '/login', params: { email: user.email, password: user.password }
        
        post '/reservations', params: {
          reservation: {
            user_id: user.id,
            event_id: event.id,
            data_prenotazione: DateTime.now
          }
        }
        
        post '/login', params: { email: manager.email, password: manager.password }

        10.times do

            new_nome = Faker::Lorem.sentence(word_count: 3)
        
            patch "/events/#{event.id}", params: {
            event: {
                nome: new_nome
                }
            }

            # Verifica che l'evento nel database sia stato aggiornato correttamente
            updated_event = Event.find(event.id)
            expect(updated_event.nome).to eq(new_nome)

            # Verifica altri attributi aggiornati se necessario
            notify_user = NotifyUser.last
            expect(notify_user).to be_present
            expect(notify_user.tipo).to match(/"nome"=>/i)
            expect(notify_user.user_id).to eq(user.id)
          


        end#fine ciclo
      end#fine it di update


      it "check notify manager" do

        post '/login', params: { email: user.email, password: user.password }

        10.times do

            user_id = Faker::Number.between(from: 18, to: 65)


            new_nome = Faker::Lorem.sentence(word_count: 3)
        
            patch "/events/#{event.id}", params: {
            event: {
                nome: new_nome
                }
            }
        
            post '/reservations', params: {
              reservation: {
                user_id: user_id,
                event_id: event.id,
                data_prenotazione: DateTime.now
              }
            }

            # # Verifica altri attributi aggiornati se necessario
            notify_manager = NotifyManager.last
            expect(notify_manager).to be_present
            expect(notify_manager.tipo).to match(/Utente/i) #contiene / inzia con utente
        
        end
      end#fine it di update


      it "check notify manager capacita raggiunta" do
        post '/login', params: { email: manager.email, password: manager.password }

        data_inizio = Faker::Time.between(from: DateTime.now, to: DateTime.now + 30.days)
        data_fine = data_inizio + Faker::Number.between(from: 1, to: 10).days

        nome = "test capacita"
        capacita = 10

        post '/events', params: {
          event: {
            nome: nome,
            luogo: Faker::Address.city,
            data_inizio: data_inizio,
            data_fine: data_fine,
            descrizione: Faker::Lorem.paragraph,
            capacita: capacita,
            capacita_corrente: 0,
            manager_id: Manager.find_by(email: "mario.rossi@example.com"),
            citta: Faker::Address.city,
            via: Faker::Address.street_name
            # Puoi aggiungere altri attributi secondo necessità
          }
        }


        e = Event.find_by(nome: nome,capacita: capacita)

        10.times do

          email = Faker::Internet.email
          password = Faker::Internet.password(min_length: 8)
          user_params = {
            nome: Faker::Name.first_name,
            cognome: Faker::Name.last_name,
            email: email,
            eta: Faker::Number.between(from: 18, to: 100),
            codice_fiscale: Faker::Alphanumeric.alphanumeric(number: 10),
            password: password
          }

          # Effettua una richiesta POST per creare un nuovo utente
          post '/users', params: { user: user_params }
          
          user_id = User.find_by(email: email,password: password)
          post '/login', params: { email: user.email, password: user.password }
          
          # puts "user id è #{user_id.id}"

          
          post '/reservations', params: {
            reservation: {
                user_id: user_id.id,
                event_id: e.id,
                data_prenotazione: DateTime.now
              }
            }

            # # Verifica altri attributi aggiornati se necessario
            notify_manager = NotifyManager.last
            expect(notify_manager).to be_present

            if e.capacita_corrente == e.capacita
              expect(notify_manager.tipo).to match(/Capacita' massima raggiunta/i)
            end
        
        end
      end#fine it di update



    end#fine patch

    # describe "Destroy" do

    #   let(:manager) do
    #     Manager.create!(
    #       nome: "Mario",
    #       cognome: "Rossi",
    #       email: "mario.rossi@example.com",
    #       password: "password"
    #     )
    #   end

    #   let(:event) do
    #       Event.create!(
    #         nome: "Evento da aggiornare",
    #         luogo: "Luogo di prova",
    #         data_inizio: DateTime.now,
    #         data_fine: DateTime.now + 1.day,
    #         descrizione: "Descrizione dell'evento",
    #         capacita: 50,
    #         capacita_corrente: 0,
    #         manager_id: manager.id,
    #         citta: "Città di prova",
    #         via: "Via di prova"
    #       )
    #     end

    #   let(:user) do
    #     User.create!(
    #       nome: Faker::Name.first_name,
    #       cognome: Faker::Name.last_name,
    #       email: Faker::Internet.email,
    #       eta: Faker::Number.between(from: 18, to: 65),
    #       codice_fiscale: Faker::Alphanumeric.alpha(number: 16).upcase,
    #       password: "password"
    #     )
    #   end

    #   let(:reservation) do
    #     Reservation.create!(
    #       user_id: user.id,
    #       event_id: event.id,
    #       data_prenotazione: DateTime.now
    #     )
    #   end

    #   it "destroys an event" do
    #     post '/login', params: { email: manager.email, password: manager.password }


   
    #     delete "/events/#{event.id}"



    #     notify_user = NotifyUser.find_by(user_id:user.id)
    #     puts notify_user.tipo
    #     expect(notify_user).to be_present

    #     # if e.capacita_corrente == e.capacita
    #     #   expect(notify_manager.tipo).to match(/Capacita' massima raggiunta/i)
    #     # end
      



    #   end




    # end


end