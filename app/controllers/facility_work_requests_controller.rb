class FacilityWorkRequestsController < ApplicationController
	
  layout 'layouts/facilities_app'

  def new
  end

  def index
  	@facility_work_requests = FacilityWorkRequest.all
  end

  def show
      @wr_comment = WorkRequestComment.all
      @labor_hours=LaborHour.all
  end

end
