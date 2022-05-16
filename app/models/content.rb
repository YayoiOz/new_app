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
  
  def save_tags(tag_list)
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
      #putsでidが出れば成功。そのidを中間テーブルで保存
      puts "=========================="
      @tag = Tag.find_by(tag_name: tag)
      puts @tag.id
      puts "=========================="
      TagContent.create!(content_id: self.id, tag_id: @tag.id)
      
      #チェックボックスがオンの時　tag_userを保存
      if tag_check == 'true'
        #ユーザーの持っているお気に入りの一番大きい値を確認
        last_potision = TagUser.find_by(user_id: current_user.id).maximum(:position)
        puts last_potision
        #TagUserのテーブルをクリエイトする
        TagUser.create!(user_id: current_user.id, tag_id: @tag.id, position: last_potision + 1)
      end
    end
  end
  

end
