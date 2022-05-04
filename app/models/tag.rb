class Tag < ApplicationRecord
    #タグとユーザーの関連付け
    has_many :tag_users, dependent: :destroy, foreign_key: 'tag_id'
    has_many :users, through: :tag_users
    accepts_nested_attributes_for :tag_users
    
    #タグとコンテンツの関連付け
    has_many :tag_contents, dependent: :destroy, foreign_key: 'tag_id'
    has_many :contents, through: :tag_contents
    accepts_nested_attributes_for :tag_contents
end
