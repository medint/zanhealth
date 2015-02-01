class BmetCostItemsController < ApplicationController
  before_action :set_bmet_cost_item, only: [:show, :edit, :update, :destroy]

  # Return all BmetCostItems
  def index
    @bmet_cost_items = BmetCostItem.all
  end

  # Return the specified BmetCostItem
  def show
  end

  # Return an empty BmetCostItem
  def new
    @bmet_cost_item = BmetCostItem.new
  end

  # Edit a specific BmetCostItem
  def edit
  end

  # Create and save a new BmetCostItem
  # to the database
  def create
    @bmet_cost_item = BmetCostItem.new(bmet_cost_item_params)
    @bmet_cost_item.facility_id = current_user.facility_id

    respond_to do |format|
      if @bmet_cost_item.save
        flash[:notice] = 'New cost item successfully added'
        format.html { redirect_to :back }
        format.json { render action: 'show', status: :created, location: @bmet_cost_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @bmet_cost_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # Update a specific BmetCostItem
  def update
    respond_to do |format|
      if @bmet_cost_item.update(bmet_cost_item_params)
        format.html { redirect_to @bmet_cost_item, notice: 'Bmet cost item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bmet_cost_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # Delete a specific BmetCostItem
  # from the database
  def destroy
    @bmet_cost_item.destroy
    respond_to do |format|
      format.html { redirect_to bmet_cost_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bmet_cost_item
      @bmet_cost_item = BmetCostItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bmet_cost_item_params
      params.require(:bmet_cost_item).permit(:name, :facility_id)
    end
end
