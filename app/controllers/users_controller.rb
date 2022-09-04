class UsersController < ApplicationController
  def index
    @users = User.order(created_at: 'desc')
    # if current_user.has_role? :admin
    #   @users = User.order(created_at: 'desc')
    # else
    #   redirect_to root_path, alert: 'Not admin'
    # end

    # authorize users using Pundit
    authorize @users
  end

  def edit
    @user = User.find(params[:id])
    # authorize user
    authorize @user
  end
  
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit({ role_ids: [] })
  end
end
