class FacilityWorkOrder < ActiveRecord::Base
  has_many :facility_work_order_comments
  belongs_to :owner, :class_name => "User"
  belongs_to :requester, :class_name => "User"
  before_save :auto_date_start

  def auto_date_start
  	if self.status == 0
  		self.date_started=nil
	elsif self.status == 1 && self.date_started==nil
		self.date_started=DateTime.now
	end

    
  end



  
end
