class Tag < ApplicationRecord
    has_many :tag_users
    has_many :users, through: :tag_users
    has_many :tag_contents
    has_many :contents, through: :tag_contents
    accepts_nested_attributes_for :tag_users
    accepts_nested_attributes_for :tag_contents
end
