class TagsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_tag, only: [:show, :edit, :update, :destroy]

    def new
      @tags = Tag.new
    end
    
  def create
    #binding.pry
      @tags = Tag.new(tag_params)
      #タグ名の重複確認
      find_tag = Tag.find_by(tag_name: @tags.tag_name)
      if find_tag == nil
        begin
          Tag.create(tag_name: @tags.tag_name)
        rescue
          nil
        end
      end
      #Tag_Users保存でお気に入りの登録
      #@tagに先程作成したタグor既存タグのデータを抽出
      @tag = Tag.find_by(tag_name: @tags.tag_name)
        #ユーザーの持っているお気に入りの一番大きい値を確認
        last_position = TagUser.select(:position).where(user_id: current_user.id) .order(position: :desc)&.first
        if last_position.blank?
          #初めてのお気に入りなので
          TagUser.create!(user_id: current_user.id, tag_id: @tag.id, position: 1)
        else
        #last_positionを整数にして保存
        last_p = last_position[:position].to_i
        #TagUserのテーブルをクリエイトする
        TagUser.create!(user_id: current_user.id, tag_id: @tag.id, position: last_p + 1)
        end
   redirect_to controller: :tag_users
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
