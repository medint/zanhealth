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
#  deleted_at        :datetime
#  pm_origin_id      :integer
#  wr_origin_id      :integer
#

class FacilityWorkOrder < ActiveRecord::Base

  include Elasticsearch::Model

  # specify the Elasticsearch index to
  # use for this model
  index_name "zanhealth-test"

=begin
  Callbacks that are used to update the ES index correctly. Note that :destroy is linked
  to the Model.destroy method which hides the record and not actually destroy it.
=end
  after_commit on: [:create] do
  	  __elasticsearch__.index_document
  end

  after_commit on: [:update] do
  	  __elasticsearch__.update_document
  end

  after_commit on: [:destroy] do
  	  __elasticsearch__.update_document
  end

  acts_as_paranoid
  has_many :facility_work_order_comments
  has_many :facility_costs
  has_many :facility_labor_hours
  belongs_to :owner, :class_name => "User"
  belongs_to :requester, :class_name => "User"
  belongs_to :pm_origin, :class_name => "FacilityPreventativeMaintenance"
  belongs_to :wr_origin, :class_name => "FacilityWorkRequest"
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

  def as_indexed_json(option={})
  	self.as_json(
  		include: { 
			owner: { only: :name },
			requester: { only: :name },
			department: { only: :name }
		})
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
  	  	  	  values[4] = item.set_status(values[4])
  	  	  	  values[5] = User.find(values[5]).name
  	  	  	  values[6] = User.find(values[6]).name
  	  	  	  values[13] = Department.find(values[13]).name 
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

  def self.find(*args)
    begin
      super
    rescue Exception => e
      deleted.find(*args)
    end
  end

end
