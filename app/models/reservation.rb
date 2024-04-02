class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :event

  after_create :increase_current_capacity
  after_destroy :decrease_current_capacity

  private
  def increase_current_capacity
      event.update(capacita_corrente: event.capacita_corrente + 1)
  end

  def decrease_current_capacity
    event.update(capacita_corrente: event.capacita_corrente - 1)
  end

end
