class TagsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_tag, only: [:show, :edit, :update, :destroy]

   # GET /tags
  def index
    #ユーザーに紐づいたタグを出したい
    @tags = current_user.tags
    @new_tags =current_user.tags.new
  end


   # POST /tags
  def create
    @tag = current_user.tags.new(tag_params)

     if @tag.save
      @status = true
    else
      @status = false
    end
  end

   # PATCH/PUT /tags/1
  def update
    if @tag.update(tag_params)
      @status = true
    else
      @status = false
    end
  end

   # DELETE /tags/1
  def destroy
    Tag.find(params[:id]).destroy()
    redirect_to tags_path
  end

   private

   # Use callbacks to share common setup or constraints between actions.
  def set_tag
    @tag = current_user.tags.find_by(id: params[:id])
  end

   # Only allow a trusted parameter "white list" through.
  def tag_params
    params.require(:tag).permit(:tag_name, :user_id)
  end
  def tag_users_params
    params.require(:tag_user).permit(:tag_id, :user_id, :position)
  end
    
end
