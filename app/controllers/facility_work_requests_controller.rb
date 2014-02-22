class FacilityWorkRequestsController < ApplicationController
	
  layout 'layouts/facilities_app'

  def new
  end

  def index
  	@facility_work_requests = FacilityWorkRequest.all
  end

  def show
    @facility_work_requests = FacilityWorkRequest.all
    @facility_work_request = FacilityWorkRequest.find(params[:id])
  end

end
