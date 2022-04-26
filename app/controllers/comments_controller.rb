class CommentsController < ApplicationController

  def create
    content = Content.find(params[:content_id])
    comment = content.comments_new
    comment.save_comment(comment, comment_params)
    redirect_to content_show_url(content)
  end
  
  private

    def comment_params
      params.require(:comment).permit(:combody).
             merge(user_id: current_user.id, content_id: params[:content_id])
    end
  
end
