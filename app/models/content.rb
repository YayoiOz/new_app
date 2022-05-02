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
  end

end
