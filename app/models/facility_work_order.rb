class FacilityWorkOrder < ActiveRecord::Base
  has_many :facility_work_order_comments
  belongs_to :owner, :class_name => "User"
  belongs_to :requester, :class_name => "User"
  belongs_to :department
  before_save :auto_date_start
  # after_initialize :init

  def auto_date_start
  	if self.status == 0
  		self.date_started=nil
	elsif self.status == 1 && self.date_started==nil
		self.date_started=DateTime.now
	end

    
  end

  # def init
  #   self.status ||=0
  #   self.save()
  # end


  
end
