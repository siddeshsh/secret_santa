class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :recipient_assignment, :incoming_assignment

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  def recipient_assignment
    return unless current_user

    current_user.secret_santa_assignment
  end

  def incoming_assignment
    return unless current_user

    current_user.reverse_assignments.secret_santa.first
  end
end
