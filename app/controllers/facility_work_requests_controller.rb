class FacilityWorkRequestsController < ApplicationController
before_action :set_facility_work_request, only: [:show, :update]

  layout 'layouts/facilities_app'

  def new
    @facility_work_requests = FacilityWorkRequest.all
    @facility_work_request = FacilityWorkRequest.new
    @users = User.where(:facility_id => user.facility.id).all.to_a
  end

  def index
  	@facility_work_requests = FacilityWorkRequest.all
  end

  def show
    @facility_work_requests = FacilityWorkRequest.all
    @input_object = FacilityWorkOrder.new
    @input_object.description = @facility_work_request.description
  end

  def update
    respond_to do |format|
      if @facility_work_request.update(facility_work_request_params)
        format.html { redirect_to @facility_work_request, notice: 'Work request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @facility_work_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_facility_work_request
    @facility_work_request = FacilityWorkRequest.find(params[:id])
  end

  def facility_work_request_params
    p params
    params.require(:facility_work_request).permit(:id, :requester, :department, :location, :phone, :email, :description, :created_at, :updated_at)
  end

end
