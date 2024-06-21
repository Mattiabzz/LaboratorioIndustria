require "test_helper"
require 'faker'
class UserTest < ActiveSupport::TestCase
  def crea_dati
    @user = User.new(nome: Faker::Name.first_name, cognome: Faker::Name.last_name, email: Faker::Internet.email,
     eta: Faker::Number.between(from: 18, to: 100), codice_fiscale: Faker::Alphanumeric.alphanumeric(number: 10), password: Faker::Internet.password(min_length: 8))
  end

  NUM_TESTS = 10

  NUM_TESTS.times do |i|

    test "dovrebbe essere valida n=#{i}" do
      @user = crea_dati
      assert @user.valid?
    end
  
    test "nome deve essere presente n=#{i}" do
      @user = crea_dati
      @user.nome = "   "
      assert_not @user.valid?
    end
  
    test "cognome deve essere presente n=#{i}" do
      @user = crea_dati
      @user.cognome = "   "
      assert_not @user.valid?
    end
  
    test "email deve essere presnete n=#{i}" do
      @user = crea_dati
      @user.email = "   "
      assert_not @user.valid?
    end
  
    test "eta deve essere presente n=#{i}" do
      @user = crea_dati
      @user.eta = nil
      assert_not @user.valid?
    end
  
    test "eta deve essere positiva n=#{i}" do
      @user = crea_dati
      @user.eta = Faker::Number.between(from: -1, to: -100)
      assert_not @user.valid?
    end

    test "codice_fiscale deve essere presente n=#{i}" do
      @user = crea_dati
      @user.codice_fiscale = "   "
      assert_not @user.valid?
    end
  
    test "email non valida n=#{i}" do
        @user = crea_dati
        @user.email = Faker::Internet.user_name(specifier: 5..10) + Faker::Internet.domain_word #mancanza @
        assert_not @user.valid?
    end

    test "password deve essere presente n=#{i}" do
      @user = crea_dati
      @user.password = ""
      assert_not @user.valid?
    end

  end#fine ciclo


end
