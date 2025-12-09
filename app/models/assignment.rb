class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :assigned_to, class_name: 'User'

  validates :event_type, presence: true
  validates :user_id, uniqueness: { scope: :event_type }
  
  scope :secret_santa, -> { where(event_type: 'secret_santa') }
  scope :revealed, -> { where(revealed: true) }
  scope :unrevealed, -> { where(revealed: false) }
end
