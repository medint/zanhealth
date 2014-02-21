class BmetWorkOrdersController < ApplicationController
  before_action :set_bmet_work_order, only: [:show, :edit, :update, :destroy]

  # GET /bmet_work_orders
  # GET /bmet_work_orders.json
  def index
#<<<<<<< HEAD
  	  #@bmet_work_orders = BmetWorkOrder.includes(:item)
  	  #@bmet_work_orders.each do |bmet_work_order|
  	  #	  user.facility == bmet_work_order.item.department.facility
    #end
#=======
  	  @bmet_work_orders = BmetWorkOrder.includes(:requester, :owner, {:item => [{:department => :facility},:model]}).where("facilities.id=?",user.facility).references(:facility)
#>>>>>>> 36101328d2f7f8d54312ac865e8443f1cf68dcb5
  end

  # GET /bmet_work_orders/1
  # GET /bmet_work_orders/1.json
  def show
      @wr_comment = BmetWorkOrderComment.where(:bmet_work_order_id => params[:id]).order(:created_at)
      @labor_hours=LaborHour.where(:bmet_work_order_id => params[:id]).all.to_a
  end

  # GET /bmet_work_orders/new
  def new
    @bmet_work_order = BmetWorkOrder.new
    @users = User.where(:facility_id => user.facility.id).all.to_a
    @items = Item.includes(:department => :facility).where("facilities.id=?",user.facility.id).references(:facility)
  end

  # GET /bmet_work_orders/1/edit
  def edit
  	  bmet_work_order = BmetWorkOrder.includes(:requester,:owner, {:item => [{:department => :facility},:model]}).where("bmet_work_orders.id=?",params[:id]).first
  	  facility = bmet_work_order.item.department.facility
  	  @item = bmet_work_order.item
  	  @users = User.where(:facility_id => facility.id).all.to_a
  end

  # POST /bmet_work_orders
  # POST /bmet_work_orders.json
  def create
    @bmet_work_order = BmetWorkOrder.new(bmet_work_order_params)

    respond_to do |format|
      if @bmet_work_order.save
        format.html { redirect_to @bmet_work_order, notice: 'Work request was successfully created.' }
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
        format.html { redirect_to @bmet_work_order, notice: 'Work request was successfully updated.' }
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
    @bmet_work_orders = BmetWorkOrder.where(owner_id: user.id)
    @texts = Text.includes(:bmet_work_order)
    @texts.each do |text|
    	user.facility == text.bmet_work_order.item.department.facility
    end
  end

  # GET /detailed_bmet_work_orders
  def detailed 
    @bmet_work_orders = BmetWorkOrder.where(owner_id: user.id)
    @texts = Text.includes(:bmet_work_order)
    @texts.each do|text|
      user.facility == text.bmet_work_order.item.department.facility
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bmet_work_order
      @bmet_work_order = BmetWorkOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bmet_work_order_params
      p params
      params.require(:bmet_work_order).permit(:date_requested, :date_expire, :date_completed, :request_type, :item_id, :cost, :description, :status, :owner_id, :requester_id, :cause_description, :action_taken, :prevention_taken)
    end
end
