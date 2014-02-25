class FacilityWorkOrderComment < ActiveRecord::Base
    belongs_to :user
    belongs_to :facility_work_order
end
