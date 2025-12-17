class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_assignment
  before_action :authorize_participants

  def create
    @messages = @assignment.messages.order(:created_at)
    @is_santa = current_user.id == @assignment.user_id
    @message = @assignment.messages.build(message_params.merge(sender: current_user))

    respond_to do |format|
      if @message.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.update("chat-errors", "")
        end
        format.html { redirect_to chat_assignment_path(@assignment) }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            "chat-errors",
            partial: "messages/errors",
            locals: { message: @message }
          ), status: :unprocessable_entity
        end
        format.html { render "chats/show", status: :unprocessable_entity }
      end
    end
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

  def message_params
    params.require(:message).permit(:body)
  end
end
