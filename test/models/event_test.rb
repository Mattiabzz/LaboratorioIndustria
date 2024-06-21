require "test_helper"
require 'faker'

class EventTest < ActiveSupport::TestCase
  
  def crea_dati 
    @manager = Manager.create!(nome: Faker::Name.first_name, cognome: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Internet.password(min_length: 8))  # Creazione di un manager fittizio

    data_inizio = Faker::Time.between(from: DateTime.now, to: DateTime.now + 30.days)
    data_fine = data_inizio + Faker::Number.between(from: 1, to: 10).days

    @event = Event.new(
      nome: Faker::Lorem.sentence,
      luogo: Faker::Address.city,
      data_inizio: data_inizio,
      descrizione: Faker::Lorem.paragraph,
      capacita: Faker::Number.between(from: 10, to: 100),
      capacita_corrente: Faker::Number.between(from: 0, to: 9),
      manager_id: @manager.id,  # Assumi che esista un manager con id 1
      data_fine: data_fine,
      citta: Faker::Address.city,
      via: Faker::Address.street_address
      )
  end

  NUM_TESTS = 10

  NUM_TESTS.times do |i|

    test "evento valido n=#{i}" do
      @event = crea_dati
      # event = Event.new(@event_attrs)
      # assert event.save
      assert @event.valid?
    end


    test "nome deve essere presente n=#{i}" do
      @event = crea_dati
      @event.nome = ""
      assert_not @event.valid?
    end

    test "luogo deve essere presente n=#{i}" do
      @event = crea_dati
      @event.luogo = ""
      assert_not @event.valid?
    end

    test "capacita deve essere presente n=#{i}" do
      @event = crea_dati
      @event.capacita = nil
      assert_not @event.valid?
    end

    test "capacita deve essere positiva n=#{i}" do
      @event = crea_dati
      @event.capacita = -1
      assert_not @event.valid?
    end

 end#fine ciclo

end
