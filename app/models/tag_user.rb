class TagUser < ApplicationRecord
    belongs_to :user, class_name: 'User'
    belongs_to :tag, class_name: 'Tag'
    
    validates :user_id, :uniqueness => { :scope => :tag_id }

    #並び替え機能
    acts_as_list
end
