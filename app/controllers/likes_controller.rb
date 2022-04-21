class LikesController < ApplicationController
    before_action :content_params
    
    def create
        Like.create(user_id: current_user.id, content_id: params[:id])
    end
    
    def destroy
        Like.find_by(user_id: current_user.id, content_id: params[:id]).destroy
    end
    
    private
    def content_params
       @content = Content.find(params[:id]) 
    end
end
