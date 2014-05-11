class BmetWorkRequestsController < ApplicationController
before_action :set_bmet_work_request, only: [:show, :update, :destroy, :edit]
before_action :set_status, only: [:show]
before_action :set_users, only: [:show], except: [:new, :create]
before_action :set_departments, only: [:show]

  layout 'layouts/bmet_app'

  def new
    @bmet_work_requests = BmetWorkRequest.all
    @bmet_work_request = BmetWorkRequest.new
  end

  def index
    @bmet_work_requests = BmetWorkRequest.all
  end

  def edit

  end

  def show
    @bmet_work_requests = BmetWorkRequest.all
    @input_object = BmetWorkOrder.new
    @input_object.description = @bmet_work_request.description
  end
 
  def update
    respond_to do |format|
      if @bmet_work_request.update(bmet_work_request_params)
        format.html { redirect_to @bmet_work_request, notice: 'Work request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bmet_work_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @bmet_work_request = BmetWorkRequest.new(bmet_work_request_params)

    respond_to do |format|
      if @bmet_work_request.save
        format.html { redirect_to @bmet_work_request, notice: 'Work order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bmet_work_request }
      else
        format.html { render action: 'new' }
        format.json { render json: @bmet_work_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bmet_work_request.destroy
    respond_to do |format|
      format.html { redirect_to bmet_work_requests_url }
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
  end#should probably be :bmet_id for set_departments and set_users, but haven't defined this yet

  def set_bmet_work_request
    set_users_special
    @bmet_work_request = BmetWorkRequest.find(params[:id])
  end

  def new_shortcut
    @bmet_work_requests = BmetWorkRequest.all
    @bmet_work_request = BmetWorkRequest.new
    render :layout => "application"
  end

  def set_users_special
    @users = params[:num]
  end

  def bmet_work_request_params
    params.require(:bmet_work_request).permit(:id, :requester, :department, :location, :phone, :email, :description, :created_at, :updated_at, :num)
  end

end
