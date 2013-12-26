class WorkRequest < ActiveRecord::Base
	belongs_to :item
    has_one :user
    has_many :work_request_comments
    has_many :texts
end
