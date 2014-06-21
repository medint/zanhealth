# == Schema Information
#
# Table name: facility_cost_items
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  facility_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class FacilityCostItem < ActiveRecord::Base
  belongs_to :facility
end
