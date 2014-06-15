class FacilityCostItemsController < ApplicationController
  before_action :set_facility_cost_item, only: [:show, :edit, :update, :destroy]

  # GET /facility_cost_items
  # GET /facility_cost_items.json
  def index
    @facility_cost_items = FacilityCostItem.all
  end

  # GET /facility_cost_items/1
  # GET /facility_cost_items/1.json
  def show
  end

  # GET /facility_cost_items/new
  def new
    @facility_cost_item = FacilityCostItem.new
  end

  # GET /facility_cost_items/1/edit
  def edit
  end

  # POST /facility_cost_items
  # POST /facility_cost_items.json
  def create
    @facility_cost_item = FacilityCostItem.new(facility_cost_item_params)

    respond_to do |format|
      if @facility_cost_item.save
        format.html { redirect_to @facility_cost_item, notice: 'Facility cost item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @facility_cost_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @facility_cost_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facility_cost_items/1
  # PATCH/PUT /facility_cost_items/1.json
  def update
    respond_to do |format|
      if @facility_cost_item.update(facility_cost_item_params)
        format.html { redirect_to @facility_cost_item, notice: 'Facility cost item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @facility_cost_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facility_cost_items/1
  # DELETE /facility_cost_items/1.json
  def destroy
    @facility_cost_item.destroy
    respond_to do |format|
      format.html { redirect_to facility_cost_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facility_cost_item
      @facility_cost_item = FacilityCostItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def facility_cost_item_params
      params.require(:facility_cost_item).permit(:name, :facility_id)
    end
end
