# == Schema Information
#
# Table name: facility_costs
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  unit_quantity          :integer
#  cost                   :integer
#  created_at             :datetime
#  updated_at             :datetime
#  facility_work_order_id :integer
#  work_request_id        :integer
#

class FacilityCost < ActiveRecord::Base
  belongs_to :facility_work_order
end
