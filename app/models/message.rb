class Message < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :assignment
  belongs_to :sender, class_name: 'User'

  scope :unread_for, ->(user) { where(read_at: nil).where.not(sender_id: user.id) }

  validates :body, presence: true, length: { maximum: 2000 }
  validate :sender_belongs_to_assignment

  after_create_commit :broadcast_message_and_counts

  private

  def sender_belongs_to_assignment
    return if assignment && [assignment.user_id, assignment.assigned_to_id].include?(sender_id)

    errors.add(:sender, "must belong to this assignment")
  end

  def broadcast_message_and_counts
    broadcast_append_to(
      assignment,
      target: dom_id(assignment, :messages),
      partial: "messages/message",
      locals: { message: self }
    )
    assignment.broadcast_unread_counts
  end
end
