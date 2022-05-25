class TrendsController < ApplicationController
    
    def index
        #tag_contentの中のcreated_atから最新1hのタグを累計で算出 
        from = Time.now - 1.hour
        to = Time.now
        @trends = TagContent.where(created_at: from..to)
    end
end
