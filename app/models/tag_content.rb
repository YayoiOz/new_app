class TagContent < ApplicationRecord
    belongs_to :content
    belongs_to :tag
    
    #validates
    validates :content_id, presence: true
    validates :tag_id, presence: true
end
