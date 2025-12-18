class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :assigned_to, class_name: 'User'
  has_many :messages, dependent: :destroy

  validates :event_type, presence: true
  validates :user_id, uniqueness: { scope: :event_type }
  
  scope :secret_santa, -> { where(event_type: 'secret_santa') }
  scope :revealed, -> { where(revealed: true) }
  scope :unrevealed, -> { where(revealed: false) }

  def unread_count_for(user)
    messages.unread_for(user).count
  end

  def broadcast_unread_count_for(user)
    Turbo::StreamsChannel.broadcast_replace_to(
      "chat_unread_counts_user_#{user.id}",
      target: "chat-count-#{id}",
      partial: "messages/chat_count_badge",
      locals: { assignment: self, count: unread_count_for(user) }
    )
  end

  def broadcast_unread_counts
    [user, assigned_to].uniq.each { |participant| broadcast_unread_count_for(participant) }
  end
end
