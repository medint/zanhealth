class FacilityLaborHour < ActiveRecord::Base
  belongs_to :facility_work_order
  belongs_to :technician, :class_name => "User"
end
