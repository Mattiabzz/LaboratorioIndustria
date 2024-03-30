class Event < ApplicationRecord
  #un evento ha un solo organizatore
  belongs_to :manager

  #un evento ha più prenotazioni
  has_many :reservation
  has_many :user,
  :through => :reservation

  #un evento ha più notifiche per gli utenti
  has_many :notify_user
  has_many :user,
:through => :notify_user

 #un evento ha più notifiche per i manager
 has_many :notify_manager
 has_many :manager,
:through => :notify_manager

validates :nome, presence: true
validates :data_fine, :data_inizio, presence: true

#validate serve per verificare tramite funzioni personalizzate
validate :data_fine_dopo_data_inizio
validates :luogo, :descrizione, :citta, :via, presence: true
validates :capacita ,presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
before_create :imposta_capacita_corrente


def data_fine_dopo_data_inizio
  #data_inizio && data_fine controlla che non sia null && poi controlla che fine sia maggiore di inizio
  if data_fine <= data_inizio
    errors.add(:data_fine, "deve essere successiva alla data di inizio")
  end
end

def imposta_capacita_corrente
  self.capacita_corrente = 0
end

end
