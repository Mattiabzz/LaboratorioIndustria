require "test_helper"

class ManagerTest < ActiveSupport::TestCase
  test "mancaza nome" do
    manager = Manager.new(cognome: "Rossi", email: "example@example.com", password: "password")
    assert_not manager.save, "Saved the manager without a nome"
  end

  test "mancanza email" do
    manager = Manager.new(nome: "Mario", cognome: "Rossi", password: "password")
    assert_not manager.save, "Saved the manager without an email"
  end

  test "tutti gli attributi" do
    manager = Manager.new(nome: "Mario", cognome: "Rossi", email: "example@example.com", password: "password")
    assert manager.save, "Couldn't save the manager with all attributes"
  end

  test "email non valida" do
    manager = Manager.new(nome: "Mario", cognome: "Rossi", email: "example.com", password: "password")
    assert_not manager.save, "Couldn't save the manager with all attributes"
  end

  test "password troppo corta" do
    manager = Manager.new(nome: "Mario", cognome: "Rossi", email: "example.com", password: "p")
    assert_not manager.save, "Couldn't save the manager with all attributes"
  end

end
