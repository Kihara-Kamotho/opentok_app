class ApplicationController < ActionController::Base
  # include Pundit (module)
  include Pundit

  # rescue from Pundit 
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized 

  private
  def after_sign_up_path(user) 
    redirect_to root_path
  end

  def after_sign_in_path(user) 
    redirect_to root_path
  end 

  def user_not_authorized 
    flash[:alert] = "You are not authorized to perform this action"
    redirect_to root_path
  end
end
