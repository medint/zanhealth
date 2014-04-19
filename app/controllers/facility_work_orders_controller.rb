class FacilityWorkOrdersController < ApplicationController
  layout 'layouts/facilities_app'
  before_action :set_facility_work_order, only: [:show, :update, :destroy, :archive]
  before_action :set_facility_work_orders, only: [:index, :new, :show]
  before_action :set_status, only: [:show, :new, :hidden]
  before_action :set_users, only: [:index, :new, :show, :hidden]
  before_action :set_departments, only: [:new, :show, :hidden]
  before_action :show_hidden_work_orders, only: [:hidden]


  def new
    @facility_work_order = FacilityWorkOrder.new

  end

  def index
  end

  def show
    @facility_work_order_comments = FacilityWorkOrderComment.where(facility_work_order_id:params[:id])
    @facility_work_order_comment = FacilityWorkOrderComment.new
    @facility_costs = FacilityCost.where(facility_work_order_id:params[:id])
    @facility_cost = FacilityCost.new
    @facility_labor_hours = FacilityLaborHour.where(facility_work_order_id:params[:id])
  	@facility_labor_hour = FacilityLaborHour.new
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

  def hidden
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

  def set_facility_work_orders
      @facility_work_orders = FacilityWorkOrder.includes(:owner, :requester, { :department => :facility}).where("facilities.id=?",current_user.facility_id).references(:facility)
  end

  def show_hidden_work_orders
  	  @facility_work_orders = FacilityWorkOrder.only_deleted.includes(:owner, :requester, { :department => :facility}).where("facilities.id=?", current_user.facility_id).references(:facility)
  end

  def destroy
 	@facility_work_order.really_destroy!
 	respond_to do |format|
 		format.html { redirect_to facility_work_orders_url }
 		format.json { head :no_content }
	end
  end
	
  def hide
  	 @facility_work_order = FacilityWorkOrder.find(params[:id])
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
    @users = User.where(:facility_id => current_user.facility.id).all.to_a
  end

  def set_departments
    @departments = Department.where(:facility_id => current_user.facility.id).all.to_a
  end

  def facility_work_order_params
      p params
      params.require(:facility_work_order).permit(:date_requested, :date_expire, :date_completed, :request_type, :item_id, :cost, :description, :status, :owner_id, :requester_id, :cause_description, :action_taken, :prevention_taken)
  end
end
