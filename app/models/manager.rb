class Manager < ApplicationRecord
#un manager ha più eventi 
has_many: event
# un manager può avere più notifiche 
has_many: notify_manager
has_many: event,
through notify_manager
end
