# == Schema Information
#
# Table name: facility_costs
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  unit_quantity          :integer
#  created_at             :datetime
#  updated_at             :datetime
#  facility_work_order_id :integer
#  cost                   :decimal(5, 2)
#

class FacilityCost < ActiveRecord::Base
  belongs_to :facility_work_order
  belongs_to :facility_cost_item
end
