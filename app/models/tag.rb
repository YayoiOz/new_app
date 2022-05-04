class Tag < ApplicationRecord
    before_save :downcase_tag_name
    #タグとユーザーの関連付け
    has_many :tag_users, dependent: :destroy, foreign_key: 'tag_id'
    has_many :users, through: :tag_users
    accepts_nested_attributes_for :tag_users
    
    #タグとコンテンツの関連付け
    has_many :tag_contents, dependent: :destroy, foreign_key: 'tag_id'
    has_many :contents, through: :tag_contents
    accepts_nested_attributes_for :tag_contents
    
    validates :tag_name, presence: true, uniqueness: true, length: { maximum: 50 }
    def save_tag(sent_tags)
      current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
      old_tags = current_tags - sent_tags
      new_tags = sent_tags - current_tags
      
      old_tags.each do |old|
        self.content_tags.delete ContentTag.find_by(tag_name: old)
      end
      
      new_tags.each do |new|
        new_content_tag = ContentTag.find_ore_create_by(tag_name: new)
        self.content_tags << new_content_tag
      end
    end

end
