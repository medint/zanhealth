class BmetCostsController < ApplicationController
  load_and_authorize_resource
  before_action :set_bmet_cost, only: [:show, :edit, :update, :destroy]

  # Return all BmetCost(s)
  def index
    @bmet_costs = BmetCost.all
  end

  # Return the specified BmetCost
  def show
  end

  # Return an empty BmetCost
  def new
    @bmet_cost = BmetCost.new
  end

  # Edit a specific BmetCost
  def edit
  end

  # Create and save a new BmetCost 
  # to the database
  def create
    @bmet_cost = BmetCost.new(bmet_cost_params)

    respond_to do |format|
      if @bmet_cost.save
        format.html { redirect_to :back, notice: 'Bmet cost was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bmet_cost }
      else
        format.html { render action: 'new' }
        format.json { render json: @bmet_cost.errors, status: :unprocessable_entity }
      end
    end
  end

  # Update a specific BmetCost
  def update
    respond_to do |format|
      if @bmet_cost.update(bmet_cost_params)
        format.html { redirect_to @bmet_cost.bmet_work_order, notice: 'Bmet cost was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bmet_cost.errors, status: :unprocessable_entity }
      end
    end
  end

  # Archive a specific BmetCost - the object
  # is not removed from the database
  def destroy
    @bmet_cost.destroy
    respond_to do |format|
      link = request.referer.split("/")[-2]
      @bmet_work_order = @bmet_cost.bmet_work_order
      if link == "hidden"
          format.html { redirect_to bmet_work_orders_url+"/hidden/"+@bmet_work_order.id.to_s, notice: 'Work order was successfully updated.' }
      elsif link == "all"
          format.html { redirect_to bmet_work_orders_url+"/all/"+@bmet_work_order.id.to_s, notice: 'Work order was successfully updated.' }
      else
        format.html { redirect_to bmet_work_orders_url+"/unhidden/"+@bmet_work_order.id.to_s, notice: 'Work order was successfully updated.' }
      end
      # format.html { redirect_to @bmet_cost.bmet_work_order }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bmet_cost
      @bmet_cost = BmetCost.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bmet_cost_params
      params.require(:bmet_cost).permit(:name, :unit_quantity, :cost, :created_at, :updated_at, :bmet_work_order_id, :work_request_id, :bmet_cost_item_id)
    end
end
