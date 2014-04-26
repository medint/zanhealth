# == Schema Information
#
# Table name: facility_work_orders
#
#  id                :integer          not null, primary key
#  date_expire       :datetime
#  date_completed    :datetime
#  request_type      :integer
#  description       :text
#  status            :integer
#  owner_id          :integer
#  requester_id      :integer
#  cause_description :text
#  action_taken      :text
#  prevention_taken  :text
#  created_at        :datetime
#  updated_at        :datetime
#  date_started      :datetime
#  department_id     :integer
#

class FacilityWorkOrder < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  acts_as_paranoid
  has_many :facility_work_order_comments
  has_many :facility_costs
  has_many :facility_labor_hours
  belongs_to :owner, :class_name => "User"
  belongs_to :requester, :class_name => "User"
  belongs_to :department
  before_save :auto_date_start
  before_create :init

  def auto_date_start
  	if self.status == 0
  		self.date_started=nil
	elsif self.status == 1 && self.date_started==nil
		self.date_started=DateTime.now
	end

  
  end

  def init
     self.status ||=0
  end



end
