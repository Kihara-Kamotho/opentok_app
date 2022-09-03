class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  # resembles index action in the users_controller
  def index? 
    @user # current_user 
    @user.has_role? :admin # this method return True if current_user is an admin otherwise raises Pundit::NotAuthorized error
  end
end
