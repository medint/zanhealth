# == Schema Information
#
# Table name: bmet_costs
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  unit_quantity      :integer
#  created_at         :datetime
#  updated_at         :datetime
#  bmet_work_order_id :integer
#  work_request_id    :integer
#  cost               :decimal(5, 2)
#

class BmetCost < ActiveRecord::Base
  belongs_to :bmet_work_order
  belongs_to :bmet_cost_item
end
