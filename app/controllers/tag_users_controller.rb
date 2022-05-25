class TagUsersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_tags
    before_action :set_tag_users, only: [:show, :edit, :update, :destroy]
    
    def index
        #ユーザーの持っているtag_user(中間)データを抽出する
       @tag_users = current_user.tag_users.order(:position)
       #@tags = current_user.tags
    end
    def move_higher
        TagUser.find(params[:id]).move_higher #move_higherメソッドでpositionを上に
        redirect_to action: :index
    end
    def move_lower
        TagUser.find(params[:id]).move_lower #move_lowerメソッドでpositionを下に
        redirect_to action: :index
    end
    def destroy
        
        @tag_users.destroy
        redirect_to action: :index
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
        params.require(:tag).permit(:tag_name, :user_id, :tag_id)
    end
    def tag_user_params
        params.require(:tag_user).permit(:tag_id, :user_id, :position)
    end
    
end
