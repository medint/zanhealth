# == Schema Information
#
# Table name: departments
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  facility_id :integer
#

class Department < ActiveRecord::Base
    has_many :bmet_needs
    has_many :bmet_items
    has_many :facility_work_orders
    has_many :bmet_work_orders
    belongs_to :facility   
end
