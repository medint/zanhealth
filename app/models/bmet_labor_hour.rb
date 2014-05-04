# == Schema Information
#
# Table name: bmet_labor_hours
#
#  id                 :integer          not null, primary key
#  date_started       :datetime
#  duration           :integer
#  technician_id      :integer
#  bmet_work_order_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

class BmetLaborHour < ActiveRecord::Base
	belongs_to :bmet_work_order
	belongs_to :technician, :class_name => "User"
    
end
