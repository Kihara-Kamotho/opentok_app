class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         
  after_create :assign_default_role

  # make first user admin
  around_save :make_first_user_admin

  validate :user_must_have_a_role, on: :update

  private

  # make the first user admin
  def make_first_user_admin 
    user = User.first!
    user.add_role :admin
  end

  def assign_default_role
    self.add_role(:newuser) if self.roles.blank?
  end

  def user_must_have_a_role
    unless roles.any?
      errors.add(:roles, "Must have at least 1 role")
    end
  end
end
