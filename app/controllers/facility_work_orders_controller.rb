class FacilityWorkOrdersController < ApplicationController
  layout 'layouts/facilities_app'
  before_action :set_facility_work_order, only: [:show, :update, :destroy]
  before_action :set_status, only: [:show, :new]
  before_action :set_users, only: [:index, :new, :show]
  before_action :set_departments, only: [:new, :show]


  def new
    @facility_work_order = FacilityWorkOrder.new
    @facility_work_orders = FacilityWorkOrder.all

  end

  def index
    @facility_work_orders = FacilityWorkOrder.all
  end

  def show

  	@facility_work_orders = FacilityWorkOrder.all
    @facility_work_order_comments = FacilityWorkOrderComment.where(facility_work_order_id:params[:id])
    @facility_costs = FacilityCost.where(facility_work_order_id:params[:id])
    @facility_labor_hours = FacilityLaborHour.where(facility_work_order_id:params[:id])
  	
    

  end

  def update
    respond_to do |format|
      if @facility_work_order.update(facility_work_order_params)
        format.html { redirect_to @facility_work_order, notice: 'Work request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @facility_work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @facility_work_order = FacilityWorkOrder.new(facility_work_order_params)

    respond_to do |format|
      if @facility_work_order.save
        format.html { redirect_to @facility_work_order, notice: 'Work order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @facility_work_order }
      else
        format.html { render action: 'new' }
        format.json { render json: @facility_work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_facility_work_order
      @facility_work_order = FacilityWorkOrder.find(params[:id])
  end

  def destroy
    @facility_work_order.destroy
    respond_to do |format|
      format.html { redirect_to facility_work_orders_url }
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

  def facility_work_order_params
      p params
      params.require(:facility_work_order).permit(:date_requested, :date_expire, :date_completed, :request_type, :item_id, :cost, :description, :status, :owner_id, :requester_id, :cause_description, :action_taken, :prevention_taken)
  end
end
