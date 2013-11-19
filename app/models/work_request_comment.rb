class WorkRequestComment < ActiveRecord::Base
    belongs_to :work_request
    belongs_to :user
end
