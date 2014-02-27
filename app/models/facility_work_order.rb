class FacilityWorkOrder < ActiveRecord::Base
  has_many :facility_work_order_comments
  belongs_to :owner, :class_name => "User"
  belongs_to :requester, :class_name => "User"
end
