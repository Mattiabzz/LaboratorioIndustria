class Event < ApplicationRecord
  #un evento ha un solo organizatore
  belongs_to :manager, optional: true 

  #un evento ha più prenotazioni
  has_many :reservations
  has_many :users,
  :through => :reservations

  #un evento ha più notifiche per gli utenti
#   has_many :notify_users
#   has_many :users,
# :through => :notify_user
  # has_many :user_notifications, class_name: 'NotifyUser'
  # has_many :notified_users, through: :user_notifications, source: :user

 #un evento ha più notifiche per i manager
#  has_many :notify_managers
#  has_many :managers,
# :through => :notify_managers
  # has_many :manager_notifications, class_name: 'NotifyManager'
  # has_many :notified_managers, through: :manager_notifications, source: :manager

validates :nome, presence: true
validates :data_fine, :data_inizio, presence: true

#validate serve per verificare tramite funzioni personalizzate
validate :data_fine_dopo_data_inizio
validates :luogo, :descrizione, :citta, :via, presence: true
validates :capacita ,presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
before_create :imposta_capacita_corrente

after_update :notify_users_of_changes
before_destroy :cancella_prenotazioni
after_update :notify_capacita_massima_raggiunta
before_update :verifica_capacita_minima


def data_fine_dopo_data_inizio
  #data_inizio && data_fine controlla che non sia null && poi controlla che fine sia maggiore di inizio
  if data_fine <= data_inizio
    errors.add(:data_fine, "deve essere successiva alla data di inizio")
  end
end

def imposta_capacita_corrente
  self.capacita_corrente = 0
end

def notify_users_of_changes
  changes = saved_changes.except('capacita_corrente','updated_at')
 
  if !changes.empty?

      users.each do |user|


        # Salva un record nella tabella notifyUser per ogni utente
        NotifyUser.create(tipo: changes,user_id: user.id)
      end

    end
end

def cancella_prenotazioni
  # Trova e cancella tutte le prenotazioni relative a questo evento

  users.each do |user|


    # Salva un record nella tabella notifyUser per ogni utente
    NotifyUser.create(tipo: "cancellazione evento " + nome,user_id: user.id)

  end

  reservations.destroy_all
end

def notify_capacita_massima_raggiunta
  # Trova e cancella tutte le prenotazioni relative a questo evento
  if capacita_corrente >= capacita
    NotifyManager.create(tipo: "Capacita' massima raggiunta " + nome,manager_id: manager.id)
  end
end

def verifica_capacita_minima
  # Controlla se il nuovo valore della capacità è inferiore alla capacità corrente
  if capacita < capacita_corrente
    errors.add(:capacita, "non può essere inferiore alla capacità corrente")
    throw :abort
  end
end



end
