class Manager < ApplicationRecord
#un manager ha più eventi 
has_many :events

# un manager può avere più notifiche 
has_many :notify_managers
#has_many :events,
#:through => :notify_managers
has_many :notification_events, through: :notify_managers, source: :event


validates :nome, presence: true
validates :cognome, presence: true
validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "invalida" }
validates :password, presence: true
end
