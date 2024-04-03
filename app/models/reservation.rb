class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :event

  after_create :increase_current_capacity
  after_destroy :decrease_current_capacity

  validate :utente_libero

  attr_accessor :cancellazione_parte_manager
  attr_accessor :cancellazione_parte_utente
  #attr_accessor :val_manager_id

  before_destroy :notifica_utente
  after_create :notifica_manager

  private
  def increase_current_capacity
      event.update(capacita_corrente: event.capacita_corrente + 1)
  end

  def decrease_current_capacity
    event.update(capacita_corrente: event.capacita_corrente - 1)
  end

  def utente_libero
    if user.reservations.joins(:event).exists?(['(events.data_inizio < ? AND events.data_fine > ?) OR (events.data_inizio < ? AND events.data_fine > ?)', event.data_fine, event.data_inizio, event.data_inizio, event.data_fine])
      errors.add(:base, "Utente non disponibile per questo evento")
    end
  end

  def notifica_utente

    if cancellazione_parte_manager == true
      # Crea un record nella tabella NotifyUser prima di cancellare la prenotazione
      NotifyUser.create(tipo: "cancellata prenotazione da parte del manager", user_id: user.id, event_id: event.id)
    elsif cancellazione_parte_utente == true
      e = Event.find(event.id)
      NotifyManager.create(tipo: "Utente ha cancellato la prenotazione => " +user.nome+" "+user.cognome, manager_id: e.manager_id, event_id: event.id)

    end
  end

  def notifica_manager

    e = Event.find(event.id)
    NotifyManager.create(tipo: "Utente ha effettuato la prenotazione => " +user.nome+" "+user.cognome, manager_id: e.manager_id, event_id: event.id)
    
  end


end
