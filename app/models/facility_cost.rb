# == Schema Information
#
# Table name: facility_costs
#
#  id                     :integer          not null, primary key
#  unit_quantity          :integer
#  created_at             :datetime
#  updated_at             :datetime
#  facility_work_order_id :integer
#  cost                   :decimal(12, 2)
#  facility_cost_item_id  :integer
#

class FacilityCost < ActiveRecord::Base
  belongs_to :facility_work_order
  belongs_to :facility_cost_item
end
