# == Schema Information
#
# Table name: bmet_labor_hours
#
#  id                 :integer          not null, primary key
#  date_started       :datetime
#  technician_id      :integer
#  bmet_work_order_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#  duration           :decimal(8, 3)
#

class BmetLaborHour < ActiveRecord::Base
	belongs_to :bmet_work_order
	belongs_to :technician, :class_name => "User"

	# Returns associated item that this labor hour was worked on
	def item
		self.bmet_work_order.bmet_item
	end

	# Returns of technician that worked this hour
	def technician_name
		self.technician.name
	end
    
end
