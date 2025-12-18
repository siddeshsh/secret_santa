class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_assignment
  before_action :authorize_participants

  def show
    @messages = @assignment.messages.order(:created_at)
    @message = Message.new
    @is_santa = current_user.id == @assignment.user_id
  end

  def read
    @assignment.messages.unread_for(current_user).update_all(read_at: Time.current)
    @assignment.broadcast_unread_count_for(current_user)
    head :ok
  end

  private

  def set_assignment
    assignment_id = params[:assignment_id] || params[:id]
    @assignment = Assignment.find(assignment_id)
  end

  def authorize_participants
    return if [@assignment.user_id, @assignment.assigned_to_id].include?(current_user.id)

    redirect_to root_path, alert: "You are not part of this chat."
  end
end
