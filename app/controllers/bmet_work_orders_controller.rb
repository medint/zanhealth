class BmetWorkOrdersController < ApplicationController
  layout 'layouts/bmet_app'
  before_action :set_bmet_work_order, only: [:show, :edit, :update, :destroy, :show_hidden,:show_all, :show_print]
  before_action :set_bmet_work_orders, only: [:index, :new, :show]
  before_action :set_users, only: [:index, :new, :show, :hidden, :all, :show_hidden, :show_all]
  before_action :set_departments, only: [:new, :show, :hidden, :all, :show_hidden, :show_all] 
  before_action :set_status, only: [:show, :new, :hidden, :all, :show_hidden, :show_all]
  before_action :set_priorities, only: [:show, :new, :hidden, :all, :show_hidden, :show_all]
  before_action :set_hidden_bmet_work_orders, only: [:hidden, :show_hidden]
  before_action :set_all_bmet_work_orders, only: [:all, :show_all, :as_csv]
  before_action :set_cost_items, only: [:show_all, :show_hidden, :show]
  after_action :set_converted_wr, only: [:create]
  after_action :reset_original_pm, only: [:create, :update]
  load_and_authorize_resource

  # GET /bmet_work_orders
  # GET /bmet_work_orders.json
  def index
  	  
  end

  def hidden
  	  render "index"
  end

  def all
  	  render "index"
  end

  def as_csv
    send_data @bmet_work_orders.as_csv, type: "text/csv", filename: "bmet_work_orders.csv"
  end

  # GET /bmet_work_orders/1
  # GET /bmet_work_orders/1.json
  def show
    @bmet_work_order_comments = BmetWorkOrderComment.where(bmet_work_order_id:params[:id])
    @bmet_work_order_comment = BmetWorkOrderComment.new
    @bmet_costs = BmetCost.where(bmet_work_order_id:params[:id])
    @bmet_cost = BmetCost.new
    @bmet_labor_hours = BmetLaborHour.where(bmet_work_order_id:params[:id])
    @bmet_labor_hour = BmetLaborHour.new
  end

  def show_hidden
	@bmet_work_order_comments = BmetWorkOrderComment.where(bmet_work_order_id:params[:id])
    @bmet_work_order_comment = BmetWorkOrderComment.new
    @bmet_costs = BmetCost.where(bmet_work_order_id:params[:id])
    @bmet_cost = BmetCost.new
    @bmet_labor_hours = BmetLaborHour.where(bmet_work_order_id:params[:id])
    @bmet_labor_hour = BmetLaborHour.new
    render "show"
  end

  def show_all
	@bmet_work_order_comments = BmetWorkOrderComment.where(bmet_work_order_id:params[:id])
    @bmet_work_order_comment = BmetWorkOrderComment.new
    @bmet_costs = BmetCost.where(bmet_work_order_id:params[:id])
    @bmet_cost = BmetCost.new
    @bmet_labor_hours = BmetLaborHour.where(bmet_work_order_id:params[:id])
    @bmet_labor_hour = BmetLaborHour.new
    render "show"
  end

  # GET /bmet_work_orders/new
  def new
    @bmet_work_order = BmetWorkOrder.new
    @items = BmetItem.includes(:department => :facility).where("facilities.id=?",current_user.facility.id).references(:facility)
    if request.referer
      link = request.referer.split("/")[-2]
      if link == "bmet_items"
        @bmet_work_order.bmet_item_id = request.referer.split("/")[-1]
      end
    end
  end

  # GET /bmet_work_orders/1/edit
  def edit
  	  bmet_work_order = BmetWorkOrder.includes(:requester,:owner, {:bmet_item => [{:department => :facility},:bmet_model]}).where("bmet_work_orders.id=?",params[:id]).first
  	  facility = bmet_work_order.bmet_item.department.facility
  	  @item = bmet_work_order.bmet_item
  	  @users = User.where(:facility_id => facility.id).all.to_a
  end

  # POST /bmet_work_orders
  # POST /bmet_work_orders.json
  def create
    @bmet_work_order = BmetWorkOrder.new(bmet_work_order_params)
    @bmet_work_order.requester_id=current_user.id

    respond_to do |format|
      if @bmet_work_order.save
        format.html { redirect_to bmet_work_orders_url+"/unhidden/"+@bmet_work_order.id.to_s, notice: 'Work order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bmet_work_order }
      else
        format.html { render :back }
        format.json { render json: @bmet_work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bmet_work_orders/1
  # PATCH/PUT /bmet_work_orders/1.json
  def update
    respond_to do |format|
      if @bmet_work_order.update(bmet_work_order_params)
    	  link = request.referer.split("/")[-2]
    	  if link == "hidden"
    	  	  format.html { redirect_to bmet_work_orders_url+"/hidden/"+@bmet_work_order.id.to_s, notice: 'Work order was successfully updated.' }
	      elsif link == "all"
    	  	  format.html { redirect_to bmet_work_orders_url+"/all/"+@bmet_work_order.id.to_s, notice: 'Work order was successfully updated.' }
	      else
        format.html { redirect_to bmet_work_orders_url+"/unhidden/"+@bmet_work_order.id.to_s, notice: 'Work order was successfully updated.' }
	      end
        format.json { head :no_content }
      else
        format.html { render :back }
        format.json { render json: @bmet_work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bmet_work_orders/1
  # DELETE /bmet_work_orders/1.json
  def destroy
    @bmet_work_order.really_destroy!
    respond_to do |format|
      format.html { redirect_to bmet_work_orders_url }
      format.json { head :no_content }
    end
  end

  def hide
  	  @bmet_work_order = BmetWorkOrder.with_deleted.find_by_id(params[:id])
  	  if @bmet_work_order.destroyed?
  	  	  BmetWorkOrder.restore(@bmet_work_order)
	  else
	  	  @bmet_work_order.destroy
	  end
	  respond_to do |format|
	  	  link = "/"+request.referer.split("/")[-2]
	  	  if link == "/all"
	  	  	  format.html { redirect_to request.referer }
		  else
		  	  link = bmet_work_orders_url+link
		  	  format.html { redirect_to link }
		  end
		  format.json { head :no_content }
	  end
  end

  # GET /my_bmet_work_orders
  def my
  	@bmet_work_orders = BmetWorkOrder.includes(:requester, :owner, {:bmet_item => [{:department => :facility},:bmet_model]}).where("facilities.id=?",current_user.facility).references(:facility)
    @texts = Text.includes(:bmet_work_order=> {:bmet_item => {:department => :facility}}).where("facilities.id=?",current_user.facility).references(:facility)
  end

  # GET /detailed_bmet_work_orders
  def detailed 
  	@bmet_work_orders = BmetWorkOrder.includes(:requester, :owner, {:bmet_item => [{:department => :facility},:bmet_model]}).where("facilities.id=?",user.facility).references(:facility)
  end

  def show_print
    render 'print_view', layout: 'blank'

  end

  private
    # Use callbacks to share common setup or constraints between actions.

    def set_bmet_work_order
      @bmet_work_order = BmetWorkOrder.with_deleted.find_by_id(params[:id])
      if (@bmet_work_order==nil || @bmet_work_order.owner.facility_id!=current_user.facility_id)
        @bmet_work_order=nil
        redirect_to "/404"
      end
    end


    def set_bmet_work_orders
      @bmet_work_orders = BmetWorkOrder.includes(:owner, :requester, { :department => :facility}).where("facilities.id=?",current_user.facility_id).references(:facility).order(:created_at).reverse_order()
      @link = bmet_work_orders_url+"/unhidden/"
    end

    def set_hidden_bmet_work_orders
      @bmet_work_orders = BmetWorkOrder.only_deleted.includes(:owner, :requester, { :department => :facility}).where("facilities.id=?",current_user.facility_id).references(:facility).order(:created_at).reverse_order()
      @link = bmet_work_orders_url+"/hidden/"
    end

    def set_all_bmet_work_orders
      @bmet_work_orders = BmetWorkOrder.with_deleted.includes(:owner, :requester, { :department => :facility}).where("facilities.id=?",current_user.facility_id).references(:facility).order(:created_at).reverse_order()
      @link = bmet_work_orders_url+"/all/"
    end

    def set_cost_items
      @cost_items = BmetCostItem.where(:facility_id => current_user.facility.id).all.to_a
    end

    def set_users
      @users = User.where(:facility_id => current_user.facility.id).all.to_a
    end

    def set_departments
      @departments = Department.where(:facility_id => current_user.facility.id).all.to_a
    end

    def set_status
      @status= {
        'Unstarted' => 0,
        'In Progress' => 1,
        'Completed' => 2
      }
    end

    def set_priorities
      @priorities = {
        'Urgent' => 0,
        'High' => 1,
        'Medium' => 2,
        'Low' => 3
      }
    end

    def set_converted_wr
      if @bmet_work_order.wr_origin_id
        @wr_origin = BmetWorkRequest.find(@bmet_work_order.wr_origin_id)
        @wr_origin.wo_convert_id = @bmet_work_order.id
        @wr_origin.converted_at = Time.zone.now      
        @wr_origin.save
        @wr_origin.destroy # hiding it immediately        
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bmet_work_order_params
      params.require(:bmet_work_order).permit(:date_requested, :date_expire, :date_completed, :request_type, :bmet_item_id, :cost, :description, :status, :owner_id, :requester_id, :cause_description, :action_taken, :prevention_taken, :department_id, :wr_origin_id, :pm_origin_id)
    end

    def reset_original_pm
      if @bmet_work_order.status == 2 and @bmet_work_order.pm_origin
        pm = @bmet_work_order.pm_origin
        pm.reset()
      end
    end

end
