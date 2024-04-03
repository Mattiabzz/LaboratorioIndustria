class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :event

  after_create :increase_current_capacity
  after_destroy :decrease_current_capacity

  validate :utente_libero

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

end
