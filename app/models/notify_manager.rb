class NotifyManager < ApplicationRecord
  belongs_to :manager
  belongs_to :event
end
