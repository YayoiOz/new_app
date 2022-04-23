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
    @contents = Content.where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: :desc)
  end
  
  def show
    @content = Content.find(params[:content_id])
    @comments = @content.comments
    @comment = @comments.new
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

    if @content.save
      
      redirect_to action: :index, flash:{ success: 'つぶやきに成功しました'}
    else
      
      redirect_to action: :index, flash:{error: 'つぶやきに失敗しました'}
    end
  end

  # PATCH/PUT /contents/1
  def update
    if @content.update(content_params)
      
      redirect_to action: :index, flash:{success: 'つぶやきを更新しました'}
    else
      
      redirect_to action: :index, flash:{error: 'つぶやきの更新に失敗しました'}
    end
  end

  # DELETE /contents/1
  def destroy
    @content.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    #元は@goal = Content.find(params[:id])だった　current_userのデータのみshow～destroyで使うってこと？
    def set_content
      @content = current_user.contents.find_by(id: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def content_params
      params.require(:content).permit(:user_id, :body)
    end
end
