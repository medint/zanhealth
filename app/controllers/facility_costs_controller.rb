class FacilityCostsController < ApplicationController
  before_action :set_facility_cost, only: [:show, :edit, :update, :destroy]

  def index
    @facility_costs=FacilityCost.all
  end
  
  def new
    @facility_cost = FacilityCost.new
  end

  def create
    @facility_cost = FacilityCost.new(facility_cost_params)

    respond_to do |format|
      if @facility_cost.save
        format.html { redirect_to :back, notice: 'Work order was successfully updated.' }
        format.json { render action: 'show', status: :created, location: @facility_cost }
      else
        format.html { render action: 'new' }
        format.json { render json: @facility_cost.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @facility_cost.update(facility_cost_params)
        format.html { redirect_to @facility_cost, notice: 'Facility Cost was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @facility_cost.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @facility_cost.destroy
    respond_to do |format|
      format.html { redirect_to @facility_cost.facility_work_order }
      format.json { head :no_content }
    end
  end

  def show      
      @facility_costs=FacilityCost.all
  end

  private 
  
    def set_facility_cost
      @facility_cost = FacilityCost.find(params[:id])
    end
    def facility_cost_params
      params.require(:facility_cost).permit(:unit_quantity, :cost, :name, :facility_work_order_id)
    end
end
