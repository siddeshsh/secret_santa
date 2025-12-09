class SpinController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.has_secret_santa_assignment?
      @assignment = current_user.secret_santa_assignment
      redirect_to result_spin_path
      return
    end

    # Get all users except current user for the wheel display
    assigned_user_ids = Assignment.secret_santa.pluck(:assigned_to_id)
    @available_users = User.where.not(id: [current_user.id] + assigned_user_ids)
  end

  def create
    if current_user.has_secret_santa_assignment?
      redirect_to result_spin_path, alert: "You've already been assigned a Secret Santa!"
      return
    end

    # Get all users except current user and those already assigned
    assigned_user_ids = Assignment.secret_santa.pluck(:assigned_to_id)
    available_users = User.where.not(id: [current_user.id] + assigned_user_ids)

    if available_users.empty?
      redirect_to spin_path, alert: "No available users for Secret Santa assignment. Please contact the administrator."
      return
    end

    # Randomly select a user
    selected_user = available_users.sample

    # Create assignment
    @assignment = Assignment.create!(
      user: current_user,
      assigned_to: selected_user,
      event_type: 'secret_santa',
      revealed: false
    )

    redirect_to result_spin_path, notice: "Your Secret Santa has been assigned!"
  end

  def result
    @assignment = current_user.secret_santa_assignment
    
    unless @assignment
      redirect_to spin_path, alert: "You haven't spun for Secret Santa yet!"
      return
    end
    
    @assigned_user = @assignment.assigned_to
  end
end
