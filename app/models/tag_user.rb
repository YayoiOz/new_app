class TagUser < ApplicationRecord
    belongs_to :user
    belongs_to :tag
    
    #並び替え機能
    acts_as_list
end
