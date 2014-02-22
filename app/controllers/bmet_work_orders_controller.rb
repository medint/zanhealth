class BmetWorkOrdersController < ApplicationController
  before_action :set_bmet_work_order, only: [:show, :edit, :update, :destroy]

  # GET /bmet_work_orders
  # GET /bmet_work_orders.json
  def index
  	  @bmet_work_orders = BmetWorkOrder.includes(:requester, :owner, {:bmet_item => [{:department => :facility},:model]}).where("facilities.id=?",user.facility).references(:facility)
  end

  # GET /bmet_work_orders/1
  # GET /bmet_work_orders/1.json
  def show
      @wr_comment = BmetWorkOrderComment.where(:bmet_work_order_id => params[:id]).order(:created_at)
      @labor_hours=BmetLaborHour.where(:bmet_work_order_id => params[:id]).all.to_a
  end

  # GET /bmet_work_orders/new
  def new
    @bmet_work_order = BmetWorkOrder.new
    @users = User.where(:facility_id => user.facility.id).all.to_a
    @items = BmetItem.includes(:department => :facility).where("facilities.id=?",user.facility.id).references(:facility)
  end

  # GET /bmet_work_orders/1/edit
  def edit
  	  bmet_work_order = BmetWorkOrder.includes(:requester,:owner, {:bmet_item => [{:department => :facility},:model]}).where("bmet_work_orders.id=?",params[:id]).first
  	  facility = bmet_work_order.bmet_item.department.facility
  	  @item = bmet_work_order.bmet_item
  	  @users = User.where(:facility_id => facility.id).all.to_a
  end

  # POST /bmet_work_orders
  # POST /bmet_work_orders.json
  def create
    @bmet_work_order = BmetWorkOrder.new(bmet_work_order_params)

    respond_to do |format|
      if @bmet_work_order.save
        format.html { redirect_to @bmet_work_order, notice: 'Work order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bmet_work_order }
      else
        format.html { render action: 'new' }
        format.json { render json: @bmet_work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bmet_work_orders/1
  # PATCH/PUT /bmet_work_orders/1.json
  def update
    respond_to do |format|
      if @bmet_work_order.update(bmet_work_order_params)
        format.html { redirect_to @bmet_work_order, notice: 'Work order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bmet_work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bmet_work_orders/1
  # DELETE /bmet_work_orders/1.json
  def destroy
    @bmet_work_order.destroy
    respond_to do |format|
      format.html { redirect_to bmet_work_orders_url }
      format.json { head :no_content }
    end
  end

  # GET /my_bmet_work_orders
  def my
  	@bmet_work_orders = BmetWorkOrder.includes(:requester, :owner, {:bmet_item => [{:department => :facility},:model]}).where("facilities.id=?",user.facility).references(:facility)
    @texts = Text.includes(:bmet_work_order=> {:bmet_item => {:department => :facility}}).where("facilities.id=?",user.facility).references(:facility)
  end

  # GET /detailed_bmet_work_orders
  def detailed 
  	@bmet_work_orders = BmetWorkOrder.includes(:requester, :owner, {:bmet_item => [{:department => :facility},:model]}).where("facilities.id=?",user.facility).references(:facility)
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bmet_work_order
      @bmet_work_order = BmetWorkOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bmet_work_order_params
      p params
      params.require(:bmet_work_order).permit(:date_requested, :date_expire, :date_completed, :request_type, :bmet_item_id, :cost, :description, :status, :owner_id, :requester_id, :cause_description, :action_taken, :prevention_taken)
    end
end
