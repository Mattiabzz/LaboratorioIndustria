class User < ApplicationRecord
#una persona può partecipare a più eventi 
has_many :reservation 
has_many :event,
:through => :reservation
#una persona ha più notifiche 
has_many :notify_user
has_many :event,
:through => :notify_user
end
