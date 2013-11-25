class WorkRequest < ActiveRecord::Base
    belongs_to :user
    has_one :item
    has_many :work_request_comments
end
