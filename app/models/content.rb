class Content < ApplicationRecord
  belongs_to :user
  belongs_to :tag, through: :tag_contents
  has_many :likes
  has_many :comments
  validates :body, presence: true
  
  def comments_new
    comments.new
  end

end
