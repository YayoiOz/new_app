class ContentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_content, only: [:show, :edit, :update, :destroy]

  # GET /contents
  def index
    #current_user.contentsはユーザーが持ってるコンテンツのみ
    @contents = current_user.contents.order(created_at: :desc)
    #@user = User.find_by(:id => @content.user_id)
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
      @status = true
    else
      @status = false
    end
  end

  # PATCH/PUT /contents/1
  def update
    if @content.update(content_params)
      @status = true
    else
      @status = false
    end
  end

  # DELETE /contents/1
  def destroy
    @content.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content
      @content = Content.find_by(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def content_params
      params.require(:content).permit(:user_id, :body)
    end
end
