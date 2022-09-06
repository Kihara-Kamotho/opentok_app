class ApplicationController < ActionController::Base
  # include Pundit (module)
  include Pundit
  # callback that ensures all actions have been authorized 
  # after_action :verify_authorized
  
  # rescue from Pundit 
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized 

  private

  def user_not_authorized 
    flash[:alert] = "You are not authorized to perform this action"
    redirect_to root_path
  end
end
