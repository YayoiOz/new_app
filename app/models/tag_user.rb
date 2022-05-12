class TagUser < ApplicationRecord
    belongs_to :user
    belongs_to :tag
    
    validates :user_id, :uniqueness => { :scope => :tag_id }

    #並び替え機能
    acts_as_list
end
