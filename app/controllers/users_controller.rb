class UsersController < ApplicationController
  before_action :set_user
  
  def edit
  end
  
  def update

    @user.update_without_password(user_params)
    redirect_to show_users_url
  end
  
  def show

  end
  
  private
    def set_user
      @user = current_user
    end
    def user_params
      params.permit(:name, :email, :profile, :password, :password_confirmation)
    end
  
end
