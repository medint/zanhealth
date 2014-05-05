class FacilityWorkOrdersController < ApplicationController
  layout 'layouts/facilities_app'
  before_action :set_facility_work_order, only: [:show, :update, :destroy, :archive, :show_hidden, :show_all]
  before_action :set_facility_work_orders, only: [:index, :new, :show]
  before_action :set_status, only: [:show, :new, :hidden, :show_hidden, :all, :show_all]
  before_action :set_users, only: [:index, :new, :show, :hidden, :show_hidden, :all, :show_all]
  before_action :set_departments, only: [:new, :show, :hidden, :show_hidden, :all, :show_all]
  before_action :set_hidden_work_orders, only: [:hidden, :show_hidden]
  before_action :set_all_work_orders, only: [:show_all, :all]

  def search
    @facility_work_orders = FacilityWorkOrder.search(params[:q]).records
    @facility_work_orders = @facility_work_orders.includes(:owner, :requester, { :department => :facility}).where("facilities.id=?",current_user.facility_id).references(:facility)    
    render action: 'index'
  end

  def new
    @facility_work_order = FacilityWorkOrder.new

  end

  def index
  	  @link = facility_work_orders_url+"/unhidden/"
  end

  def show
    @facility_work_order_comments = FacilityWorkOrderComment.where(facility_work_order_id:params[:id])
    @facility_work_order_comment = FacilityWorkOrderComment.new
    @facility_costs = FacilityCost.where(facility_work_order_id:params[:id])
    @facility_cost = FacilityCost.new
    @facility_labor_hours = FacilityLaborHour.where(facility_work_order_id:params[:id])
  	@facility_labor_hour = FacilityLaborHour.new
  end

  def show_hidden
	@facility_work_order_comments = FacilityWorkOrderComment.where(facility_work_order_id:params[:id])
    @facility_work_order_comment = FacilityWorkOrderComment.new
    @facility_costs = FacilityCost.where(facility_work_order_id:params[:id])
    @facility_cost = FacilityCost.new
    @facility_labor_hours = FacilityLaborHour.where(facility_work_order_id:params[:id])
  	@facility_labor_hour = FacilityLaborHour.new
  	render "show"
  end

  def show_all
	@facility_work_order_comments = FacilityWorkOrderComment.where(facility_work_order_id:params[:id])
    @facility_work_order_comment = FacilityWorkOrderComment.new
    @facility_costs = FacilityCost.where(facility_work_order_id:params[:id])
    @facility_cost = FacilityCost.new
    @facility_labor_hours = FacilityLaborHour.where(facility_work_order_id:params[:id])
  	@facility_labor_hour = FacilityLaborHour.new
  	render "show"
  end

  def update
    respond_to do |format|
      if @facility_work_order.update(facility_work_order_params)
      	  link = request.referer.split("/")[-2]
      	if link == "hidden"
      		format.html { redirect_to facility_work_orders_url+"/hidden/"+@facility_work_order.id.to_s, notice: 'Work order was successfully updated.' }
		elsif link == "all"
			format.html { redirect_to facility_work_orders_url+"/all/"+@facility_work_order.id.to_s, notice: 'Work order was successfully updated.' }
		else
        	format.html { redirect_to facility_work_orders_url+"/unhidden/"+@facility_work_order.id.to_s, notice: 'Work order was successfully updated.' }
		end
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @facility_work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  def all
  	  @link = facility_work_orders_url+"/all/"
  	  render "index"
  end

  def hidden
  	  @link = facility_work_orders_url+"/hidden/"
  	  render "index"
  end

  def create
    @facility_work_order = FacilityWorkOrder.new(facility_work_order_params)

    respond_to do |format|
      if @facility_work_order.save
        format.html { redirect_to facility_work_orders_url+"/unhidden/"+@facility_work_order.id.to_s, notice: 'Work order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @facility_work_order }
      else
        format.html { render action: 'new' }
        format.json { render json: @facility_work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_facility_work_order
      @facility_work_order = FacilityWorkOrder.with_deleted.find(params[:id])
  end

  def set_facility_work_orders
      @facility_work_orders = FacilityWorkOrder.includes(:owner, :requester, { :department => :facility}).where("facilities.id=?",current_user.facility_id).references(:facility).order(:created_at)
  end

  def set_hidden_work_orders
  	  @facility_work_orders = FacilityWorkOrder.only_deleted.includes(:owner, :requester, { :department => :facility}).where("facilities.id=?", current_user.facility_id).references(:facility)
  end

  def set_all_work_orders
  	  @facility_work_orders = FacilityWorkOrder.with_deleted.includes(:owner, :requester, { :department => :facility}).where("facilities.id=?", current_user.facility_id).references(:facility)
  end

  def destroy
 	@facility_work_order.really_destroy!
 	respond_to do |format|
 		format.html { redirect_to facility_work_orders_url }
 		format.json { head :no_content }
	end
  end
	
  def hide
  	 @facility_work_order = FacilityWorkOrder.with_deleted.find(params[:id])
  	 if @facility_work_order.destroyed?
  	 	 FacilityWorkOrder.restore(@facility_work_order.id)
	 else
	 	 @facility_work_order.destroy
	end
    respond_to do |format|
      link = "/"+request.referer.split("/")[-2]
      	if link == "/all"
      		format.html { redirect_to request.referer }
		else
      	link = facility_work_orders_url+link
	  	format.html { redirect_to link }
		end
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
      params.require(:facility_work_order).permit(:date_requested, :date_expire, :date_completed, :request_type, :item_id, :cost, :description, :status, :owner_id, :requester_id, :cause_description, :action_taken, :prevention_taken)
  end
end
