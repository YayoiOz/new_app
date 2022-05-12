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
          #この下で中間テーブルを作成しようとすると先にリダイレクトが入ってしまう
          TagContent.create!(content_id: self.id, tag_id: tag.attributes['id'])
          puts "=========================="

        # 例外が発生すると rescue 内の処理が走り nil となるので
        # 値は保存されないで次の処理に進む
        rescue
          nil
        end
      else
            # DB にタグが存在した場合、中間テーブルにブログ記事とタグを紐付けている
        TagContent.create!(content_id: self.id, tag_id: find_tag.id)
        
      end
      
    end
  end

end
