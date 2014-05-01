# == Schema Information
#
# Table name: bmet_costs
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  unit_quantity      :integer
#  cost               :integer
#  created_at         :datetime
#  updated_at         :datetime
#  bmet_work_order_id :integer
#  work_request_id    :integer
#

class BmetCost < ActiveRecord::Base
  belongs_to :bmet_work_order
end
