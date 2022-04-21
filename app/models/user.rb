class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  validates :profile, length: { maximum: 200 }
  
  has_many :contents
  has_many :likes
  
  #follow(rerationship)用の記述
  has_many :relationships, class_name: "Relationship", foreign_key: "follow_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "target_id", dependent: :destroy
  # 一覧画面で使う
  has_many :followings, through: :relationships, source: :target
  has_many :followers, through: :reverse_of_relationships, source: :follow
  
  #フォロー用のメソッド
  def follow(user_id)
    relationships.find_or_create_by(target_id: user_id)
  end
  def unfollow(user_id)
    relationships.find_by(target_id: user_id).destroy
  end
  def following?(user)
    followings.include?(user)
  end
  
  #いいね機能のメソッド
  def like_by?(content_id)
    likes.where(content_id: content_id).exists?
  end
  
  

end
