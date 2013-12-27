class WorkRequest < ActiveRecord::Base
    belongs_to :item
    belongs_to :user
    has_many :work_request_comments
    has_many :texts
    belongs_to :owner, :class_name => "User"
    belongs_to :requester, :class_name => "User"
end
