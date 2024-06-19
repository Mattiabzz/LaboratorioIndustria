require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(nome: "John", cognome: "Doe", email: "john.doe@example.com", eta: 30, codice_fiscale: "ABC123XYZ", password: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "nome should be present" do
    @user.nome = "   "
    assert_not @user.valid?
  end

  test "cognome should be present" do
    @user.cognome = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end

  test "eta should be present" do
    @user.eta = nil
    assert_not @user.valid?
  end

  test "codice_fiscale should be present" do
    @user.codice_fiscale = "   "
    assert_not @user.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[userexample,com user_at_foo.org user.nameexample. fooar_baz.com foobar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

end
