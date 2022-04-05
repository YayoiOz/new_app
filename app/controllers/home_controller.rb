class HomeController < ApplicationController
    #サインインしていたらコンテンツにリダイレクトする
    def index
        redirect_to contents_path if user_signed_in?
    end
    #そうでない場合home#indexに飛ぶ
end
