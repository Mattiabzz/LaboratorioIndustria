require "test_helper"
require 'faker'

class ManagerTest < ActiveSupport::TestCase
  
  def crea_dati 
    @manager = Manager.create!(nome: Faker::Name.first_name, cognome: Faker::Name.last_name, email: Faker::Internet.email, password: Faker::Internet.password(min_length: 8))  # Creazione di un manager fittizio
  end

  NUM_TESTS = 10

  NUM_TESTS.times do |i|

    test "mancaza nome n=#{i}" do
      @manager = crea_dati
      @manager.nome = ""
      assert_not  @manager.valid?
    end
  
    test "mancanza email n=#{i}" do
      @manager = crea_dati
      @manager.email = ""
      assert_not  @manager.valid?
    end
  
    test "tutti gli attributi n=#{i}" do
      @manager = crea_dati
      assert @manager.valid?
    end
  
    test "email non valida n=#{i}" do
      @manager = crea_dati
      @manager.email = Faker::Internet.user_name(specifier: 5..10) + Faker::Internet.domain_word #mancanza @
      assert_not @manager.valid?
    end
  
    test "password mancante n=#{i}" do
      @manager = crea_dati
      @manager.password = ""
      assert_not @manager.valid?
    end

  end #fine ciclo


end
