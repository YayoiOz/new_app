class Relationship < ApplicationRecord
    belongs_to :follow, class_name: 'User'
    belongs_to :target, class_name: 'User'

end
