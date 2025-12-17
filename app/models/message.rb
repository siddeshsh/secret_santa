class Message < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :assignment
  belongs_to :sender, class_name: 'User'

  validates :body, presence: true, length: { maximum: 2000 }
  validate :sender_belongs_to_assignment

  after_create_commit -> {
    broadcast_append_to(
      assignment,
      target: dom_id(assignment, :messages),
      partial: "messages/message",
      locals: { message: self }
    )
  }

  private

  def sender_belongs_to_assignment
    return if assignment && [assignment.user_id, assignment.assigned_to_id].include?(sender_id)

    errors.add(:sender, "must belong to this assignment")
  end
end
