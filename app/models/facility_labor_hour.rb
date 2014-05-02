# == Schema Information
#
# Table name: facility_labor_hours
#
#  id                     :integer          not null, primary key
#  date_started           :datetime
#  duration               :integer
#  technician_id          :integer
#  facility_work_order_id :integer
#  created_at             :datetime
#  updated_at             :datetime
#

class FacilityLaborHour < ActiveRecord::Base
  belongs_to :facility_work_order
  belongs_to :technician, :class_name => "User"  
end
