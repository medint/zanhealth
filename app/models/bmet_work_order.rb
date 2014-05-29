# == Schema Information
#
# Table name: bmet_work_orders
#
#  id                :integer          not null, primary key
#  date_requested    :datetime
#  date_expire       :datetime
#  date_completed    :datetime
#  request_type      :integer
#  bmet_item_id      :integer
#  cost              :integer
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
#  deleted_at        :datetime
#  pm_origin         :integer
#  wr_origin         :integer
#

class BmetWorkOrder < ActiveRecord::Base
	acts_as_paranoid
    belongs_to :bmet_item
    has_many :bmet_work_order_comments
    has_many :bmet_costs
    has_many :bmet_labor_hours
    belongs_to :owner, :class_name => "User"
    belongs_to :requester, :class_name => "User"
    belongs_to :pm_origin, :class_name => "BmetPreventativeMaintenance"
    belongs_to :wr_origin, :class_name => "BmetWorkRequest"
    belongs_to :department
    before_save :auto_date_start
  	before_create :init

    def auto_date_start
  	if self.status == 0
  		self.date_started=nil
  	elsif self.status == 1 && self.date_started==nil
  		self.date_started=DateTime.now
  	end
    if self.status == 2 &&self.date_completed==nil
      self.date_completed=DateTime.now
    end  
  end

  def init
     self.status ||=0
  end

  def self.as_csv
  	  colnames = column_names.dup
  	  colnames.shift
  	  CSV.generate do |csv|
  	  	  csv << colnames
  	  	  all.each do |item|
  	  	  	  values = item.attributes.values_at(*colnames)
  	  	  	  values[7] = item.set_status(values[7])
  	  	  	  values[8] = User.find_by_id(values[8]).try(:name)
  	  	  	  values[9] = User.find_by_id(values[9]).try(:name)
  	  	  	  values[16] = Department.find_by_id(values[16]).try(:name) 
  	  	  	  csv << values
		  end
	  end
  end

  def set_status(status)
  	if status == 0
  		return "Uncompleted"
  	elsif status == 1
  		return "In Progress"
	else 
		return "Completed"
	end
  end
end
