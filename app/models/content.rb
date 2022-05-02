class Content < ApplicationRecord
  belongs_to :user
  
  has_many :tag, through: :tag_contents
  has_many :tag_contents, dependent: :destroy
  
  has_many :likes
  has_many :comments
  
  validates :body, presence: true
  
  def comments_new
    comments.new
  end
  
  def save_tags(tags)
    #タグをスペース区切りで分割・配列化
    #　空白対応のために+を入れている
    tag_list = tags.splot(/[[:blank:]]+/)
    
    current_tags = self.tags.pluck(:name)
    
    #　1）元々自分に紐付いていたタグと投稿されたタグの差分を抽出
    #　　-- 記事更新時に削除されたタグ
    old_tags =current_tags - tag_list
    
    #　2）投稿されたタグと元々自分に紐付いていたタグの差分を抽出
    # 　　-- 新規に追加されたタグ
    new_tags = tag_list - current_tags
    p current_tags
    
    #tag_content から　1を削除
    
  end

end
