class ContentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_content, only: [:show, :edit, :update, :destroy]

  # GET /contents
  def index
    #ユーザーが持ってるコンテンツのみ(current_user.contentsしてるから)
    #@contents = current_user.contents.order(created_at: :desc)
    #コンテンツテーブルから全部のデータを引っ張ってくる
    #@contents = Content.all
    #最終目標：current_userとtarget_idのユーザーのコンテンツを降順で表示
    @tag_list = Tag.all
    @contents = Content.where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: :desc)
    #@content = current_user.content.new #ビューのform_withのmodelに使う
  end
  
  def show
    @content = Content.find(params[:content_id])
    @comments = @content.comments
    @comment = @comments.new
    @content_tags = @content.tag
  end

  # GET /contents/new
  def new
    @content = current_user.contents.new
  end

  # GET /contents/1/edit
  def edit
    
  end

  # POST /contents
  def create
    @content = current_user.contents.new(content_params)
    @content.user_id = current_user.id
    tag_list = tag_params[:content][:tag_name].split(nil)
    if @content.save
      #タグの保存
      @content.save_tag(tag_list)
      #トップへリダイレクト
      redirect_to action: :index, flash:{ success: 'つぶやきに成功しました'}
    else
      
      render :new
    end
  end

  # PATCH/PUT /contents/1
  def update
    if @content.update(content_params)
      @content.save_tags(params[:content][:tag])
      redirect_to action: :index, flash:{success: 'つぶやきを更新しました'}
    else
      
      render :edit
    end
  end

  # DELETE /contents/1
  def destroy
    @content.destroy
    redirect_to action: :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    #元は@goal = Content.find(params[:id])だった　current_userのデータのみshow～destroyで使うってこと？
    def set_content
      @content = current_user.contents.find_by(id: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def content_params
      params.require(:content).permit(:user_id, :body, :tag_name)
    end
    #def tag_params
    #  params.require(:content).permit(:tag_name)
    #end
    
end
