class WorkRequest < ActiveRecord::Base
    belongs_to :user
    has_one :item
    has_many :work_request_comments
    has_many :texts
end
