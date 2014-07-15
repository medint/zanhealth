class FacilityWorkOrdersController < ApplicationController
  load_and_authorize_resource
  layout 'layouts/facilities_app'
  before_action :set_facility_work_order, only: [:show, :update, :destroy, :archive, :show_hidden, :show_all]
  before_action :set_facility_work_orders, only: [:index, :new, :show]
  before_action :set_status, only: [:show, :new, :hidden, :show_hidden, :all, :show_all]
  before_action :set_users, only: [:index, :new, :show, :hidden, :show_hidden, :all, :show_all]
  before_action :set_departments, only: [:new, :show, :hidden, :show_hidden, :all, :show_all] 
  before_action :set_hidden_work_orders, only: [:hidden, :show_hidden]
  before_action :set_all_work_orders, only: [:show_all, :all, :as_csv]
  before_action :set_cost_items, only: [:show_all, :show_hidden, :show]
  after_action :set_converted_wr, only: [:create]
  after_action :reset_original_pm, only: [:create, :update]

  def search
    @facility_work_orders = FacilityWorkOrder.search(params[:q], :size => 100).records
    @facility_work_orders = @facility_work_orders.with_deleted.includes(:owner, :requester, { :department => :facility}).where("facilities.id=?",current_user.facility_id).references(:facility)    
    @link = facility_work_orders_url+"/all/"
    render action: 'index'
  end

  def new
    @facility_work_order = FacilityWorkOrder.new

  end

  def index  	  
  end

  def as_csv
  	  	 send_data @facility_work_orders.as_csv, type: "text/csv", filename: "facility_work_orders.csv"
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
        format.html { redirect_to :back }
        format.json { render json: @facility_work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  def all  	  
  	  render "index"
  end

  def hidden
  	  render "index"
  end

  def create
    @facility_work_order = FacilityWorkOrder.new(facility_work_order_params)
    @facility_work_order.requester_id=current_user.id

    respond_to do |format|
      if @facility_work_order.save
        format.html { redirect_to facility_work_orders_url+"/unhidden/"+@facility_work_order.id.to_s, notice: 'Work order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @facility_work_order }
      else
        format.html { redirect_to :back }
        format.json { render json: @facility_work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
 	@facility_work_order.really_destroy!
 	respond_to do |format|
 		format.html { redirect_to facility_work_orders_url }
 		format.json { head :no_content }
	end
  end
	
  def hide
  	@facility_work_order = FacilityWorkOrder.with_deleted.find_by_id(params[:id])
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

  private 
    def set_status
      @status= {
        'Unstarted' => 0,
        'In Progress' => 1,
        'Completed' => 2
      }
    end

    def set_facility_work_order
        @facility_work_order = FacilityWorkOrder.with_deleted.find_by_id(params[:id])
        if (@facility_work_order==nil || @facility_work_order.owner.facility_id!=current_user.facility_id)
          @facility_work_order=nil
          redirect_to "/404"
        end

    end

    def set_facility_work_orders
        @facility_work_orders = FacilityWorkOrder.includes(:owner, :requester, { :department => :facility}).where("facilities.id=?",current_user.facility_id).references(:facility).order(:created_at).reverse_order()
        @link = facility_work_orders_url+"/unhidden/"
    end

    def set_hidden_work_orders
        @facility_work_orders = FacilityWorkOrder.only_deleted.includes(:owner, :requester, { :department => :facility}).where("facilities.id=?", current_user.facility_id).references(:facility).order(:created_at).reverse_order()
        @link = facility_work_orders_url+"/hidden/"
    end

    def set_all_work_orders
        @facility_work_orders = FacilityWorkOrder.with_deleted.includes(:owner, :requester, { :department => :facility}).where("facilities.id=?", current_user.facility_id).references(:facility).order(:created_at).reverse_order()
        @link = facility_work_orders_url+"/all/"
    end


    def set_users
      @users = User.where(:facility_id => current_user.facility.id).all.to_a
    end

    def set_departments
      @departments = Department.where(:facility_id => current_user.facility.id).all.to_a
    end

    def set_cost_items
      @cost_items = FacilityCostItem.where(:facility_id => current_user.facility.id).all.to_a
    end

    def set_converted_wr
      if @facility_work_order.wr_origin_id
        @wr_origin = FacilityWorkRequest.find(@facility_work_order.wr_origin_id)
        @wr_origin.wo_convert_id = @facility_work_order.id
        @wr_origin.converted_at = Time.zone.now      
        @wr_origin.save
        @wr_origin.destroy # hiding it immediately        
      end
    end

    def facility_work_order_params
        params.require(:facility_work_order).permit(:date_requested, :date_expire, :date_completed, :request_type, :item_id, :department_id, :cost, :description, :status, :owner_id, :requester_id, :cause_description, :action_taken, :prevention_taken, :pm_origin_id, :wr_origin_id)
    end

    def reset_original_pm
      if @facility_work_order.status == 2 and @facility_work_order.pm_origin
        pm = @facility_work_order.pm_origin
        pm.reset()
      end
    end
end
