class Event < ApplicationRecord
  #un evento ha un solo organizatore
  belongs_to :manager
  #un evento ha più prenotazioni
  has_many: reservation
  has_many: user,
through reservation
  #un evento ha più notifiche per gli utenti
  has_many: notify_user
  has_many: user,
through notify_user
 #un evento ha più notifiche per i manager
 has_many: notify_manager
 has_many: manager,
through notify_manager
end
