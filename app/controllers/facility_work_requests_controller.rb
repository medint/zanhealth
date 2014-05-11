class FacilityWorkRequestsController < ApplicationController
before_action :set_facility_work_request, only: [:show, :update, :destroy, :public_show]
before_action :set_facility_work_requests, only:[:new, :index, :show, :search]
before_action :set_status, only: [:show]
before_action :set_users, only: [:show], except: [:new, :create]
before_action :set_departments, only: [:show]
skip_before_action :authenticate_user!, only: [:public_new, :public_create, :public_show]

  layout 'layouts/facilities_app'

  def search
    @facility_work_requests = FacilityWorkRequest.search(params[:q]).records
    @facility_work_requests = @facility_work_requests.where(:facility_id => current_user.facility_id).all.to_a
    render action: "index"
  end

  def new
    @facility_work_request = FacilityWorkRequest.new
  end



  def index
  end

  def show
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
    @facility_work_request.facility_id=current_user.facility_id

    respond_to do |format|
      if @facility_work_request.save
        format.html { redirect_to @facility_work_request, notice: 'Work request was successfully created.' }
        format.json { render action: 'show', status: :created, location: @facility_work_request }
      else
        format.html { render action: 'new' }
        format.json { render json: @facility_work_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def public_new    
    @facility_work_request = FacilityWorkRequest.new
    @facility_work_request.facility_id = params[:facility_id]
    render :layout => "application"
  end

  def public_create    
    @facility_work_request = FacilityWorkRequest.new(facility_work_request_params)

    respond_to do |format|
      if verify_recaptcha(private_key: ENV['RECAPTCHA_PRIVATE_KEY']) && @facility_work_request.save
        format.html { redirect_to '/facility_work_requests/public_show/'+@facility_work_request.id.to_s, notice: 'Work order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @facility_work_request }
      else
        format.html { render action: 'public_new', layout: "application" }
        format.json { render json: @facility_work_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def public_show
    render :layout => "application"
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
    @users = User.where(:facility_id => current_user.facility_id).all.to_a
  end

  def set_departments
    @departments = Department.where(:facility_id => current_user.facility_id).all.to_a
  end

  def set_facility_work_request
    @facility_work_request = FacilityWorkRequest.find(params[:id])
  end

  def set_facility_work_requests
    @facility_work_requests = FacilityWorkRequest.where(:facility_id => current_user.facility_id).all.to_a
  end

  def facility_work_request_params
    params.require(:facility_work_request).permit(:id, :requester, :department, :location, :phone, :email, :description, :created_at, :updated_at, :facility_id)
  end

end
