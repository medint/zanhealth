# == Schema Information
#
# Table name: bmet_costs
#
#  id                 :integer          not null, primary key
#  unit_quantity      :integer
#  created_at         :datetime
#  updated_at         :datetime
#  bmet_work_order_id :integer
#  work_request_id    :integer
#  cost               :decimal(12, 2)
#  bmet_cost_item_id  :integer
#

class BmetCost < ActiveRecord::Base
  belongs_to :bmet_work_order
  belongs_to :bmet_cost_item
end
