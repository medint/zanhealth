class BmetWorkOrderComment < ActiveRecord::Base
    belongs_to :user
    belongs_to :bmet_work_order
end
