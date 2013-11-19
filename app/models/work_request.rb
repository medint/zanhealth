class WorkRequest < ActiveRecord::Base
    has_many :work_request_comments
    has_one :item
    belongs_to :user
end
