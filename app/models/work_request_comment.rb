class WorkRequestComment < ActiveRecord::Base
    belongs_to :user
    belongs_to :work_request
end
