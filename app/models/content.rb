class Content < ApplicationRecord
  belongs_to :user
  
  has_many :tag_contents, dependent: :destroy
  has_many :tags, through: :tag_contents
  
  has_many :likes
  has_many :comments
  
  validates :body, presence: true
  
  def comments_new
    comments.new
  end
  
  def save_tags(tag_list, tag_check)
    tag_list.each do |tag|
      # 受け取った値を小文字に変換して、DBを検索して存在しない場合は
      # find_tag に nil が代入され　nil となるのでタグの作成が始まる
      find_tag = Tag.find_by(tag_name: tag.downcase)
      if find_tag == nil
        begin
          # create メソッドでタグの作成
          # create! としているのは、保存が成功しても失敗してもオブジェクト
          # を返してしまうため、例外を発生させたい
          puts "=========================="
          puts self.id
          puts tag
          puts find_tag
          puts "=========================="
          Tag.create(tag_name: tag)
        # 例外が発生すると rescue 内の処理が走り nil となるので
        # 値は保存されないで次の処理に進む
        rescue
          nil
        end
      else
        
      end
      #tag_list.eachの最後にcreateを実行
      #@tagに先程作成したタグor既存タグのデータを抽出
      @tag = Tag.find_by(tag_name: tag)
      TagContent.create!(content_id: self.id, tag_id: @tag.id)
      #チェックボックスがオンの時　tag_userを保存
      #binding.pry
      if tag_check.blank?
        #tag_check空なので通過
      else  #tag_checkオンでblankじゃなくなる
        #ユーザーの持っているお気に入りの一番大きい値を確認
        last_position = TagUser.select(:position).where(user_id: user.id) .order(position: :desc)&.first
        #binding.pry
        if last_position.blank?
          #初めてのお気に入りなので
          TagUser.create!(user_id: user.id, tag_id: @tag.id, position: 1)
        else
        #binding.pry
        #last_positionを整数にして保存
        last_p = last_position[:position].to_i
        #TagUserのテーブルをクリエイトする
        TagUser.create!(user_id: user.id, tag_id: @tag.id, position: last_p + 1)
        end
      end
    end
  end

end
