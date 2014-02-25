class FacilityWorkRequest < ActiveRecord::Base
    belongs_to :requester, :class_name => "User"
end
