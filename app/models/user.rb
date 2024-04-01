class User < ApplicationRecord
    
#una persona può partecipare a più eventi 
has_many :reservation 
has_many :event,
:through => :reservation

#una persona ha più notifiche 
has_many :notify_user
has_many :event,
:through => :notify_user

validates :nome, presence: true
validates :cognome, presence: true
validates :eta, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
validates :codice_fiscale, presence: true
#, uniqueness: true, format: { with: /\A[A-Z]{6}\d{2}[A-Z]\d{2}[A-Z]\d{3}[A-Z]\z/,message: "deve essere un codice fiscale valido" }
validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "invalida" }
validates :password, presence: true
end
