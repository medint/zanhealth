class WorkRequest < ActiveRecord::Base
    belongs_to :item
    belongs_to :user
    has_many :work_request_comments
    has_many :texts
end
