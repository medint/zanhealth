class FacilityWorkRequestsController < ApplicationController
skip_before_action :authenticate, except: [:show, :index, :update, :destroy]
before_action :set_facility_work_request, only: [:show, :update, :destroy]
before_action :set_status, only: [:show]
before_action :set_users, only: [:show], except: [:new, :create]
before_action :set_departments, only: [:show]

  layout 'layouts/facilities_app'

  def new
    @facility_work_requests = FacilityWorkRequest.all
    @facility_work_request = FacilityWorkRequest.new
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

  def create
    @facility_work_request = FacilityWorkRequest.new(facility_work_request_params)

    respond_to do |format|
      if @facility_work_request.save
        format.html { redirect_to @facility_work_request, notice: 'Work order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @facility_work_request }
      else
        format.html { render action: 'new' }
        format.json { render json: @facility_work_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @facility_work_request.destroy
    respond_to do |format|
      format.html { redirect_to facility_work_requests_url }
      format.json { head :no_content }
    end
  end

  def set_status
    @status= {
      'Unstarted' => 0,
      'In Progress' => 1,
      'Completed' => 2
    }
  end

  def set_users
    @users = User.where(:facility_id => user.facility.id).all.to_a
  end

  def set_departments
    @departments = Department.where(:facility_id => user.facility.id).all.to_a
  end

  def set_facility_work_request
    set_users_special
    @facility_work_request = FacilityWorkRequest.find(params[:id])
  end

  def new_shortcut
    @facility_work_requests = FacilityWorkRequest.all
    @facility_work_request = FacilityWorkRequest.new
    render :layout => "minimal"
  end

  def set_users_special
    @users = params[:num]
  end

  def facility_work_request_params
    p params
    params.require(:facility_work_request).permit(:id, :requester, :department, :location, :phone, :email, :description, :created_at, :updated_at, :num)
  end

end
