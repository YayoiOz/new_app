class Comment < ApplicationRecord
    belongs_to :content
    belongs_to :user
    
    def save_comment(comment, comment_params)
       comment.combody = comment_params[:combody]
       comment.user_id = comment_params[:user_id]
       comment.content_id = comment_params[:content_id]
       save
    end
    
end
