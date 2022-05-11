class UsersController < ApplicationController
  
  
  def edit
    set_user
  end
  
  def update
    set_user
    @user.update_without_password(user_params)
    redirect_to root_path
  end
  
  def show
    set_user
  end
  
  def profile
    @user = User.find_by(id: params[:user_id])
  end
  
  private
    def set_user
      @user = current_user
    end

    def user_params
      params.permit(:name, :email, :profile, :avatar, :password, :password_confirmation)
    end
  
end
