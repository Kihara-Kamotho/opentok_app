class ApplicationController < ActionController::Base
  # include Pundit (module)
  include Pundit

  private
  def after_sign_up_path(user) 
    redirect_to root_path
  end

  def after_sign_in_path(user) 
    redirect_to root_path
  end 
end
