class TagUsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_tags
    before_action :set_tag_users, only: [:show, :edit, :update, :destroy]
    
    def index
       @tag_users = current_user.tag_users
       @tags = current_user.tags
       @new_tags =current_user.tag_users.new
    end
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag_users
        @tag_users = current_user.tag_users.find_by(id: params[:id])
    end
    def set_tags
        @tag =current_user.tags.find_by(id: params[:id]) 
    end
    
    # Only allow a trusted parameter "white list" through.
    def tag_params
        params.require(:tag).permit(:tag_name, :user_id)
    end
    def tag_user_params
        params.require(:tag_user).permit(:tag_id, :user_id, :position)
    end
    
end
