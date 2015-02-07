class BmetItemHistoriesController < ApplicationController
  load_and_authorize_resource param_method: :item_history_params
  before_action :set_item_history, only: [:show, :edit, :update, :destroy]

  # Return all BmetItemHistories
  def index
    @item_histories = BmetItemHistory.all
  end

  # Return a specific BmetItemHistory
  def show
  end

  # Return an empty BmetItemHistory
  def new
    @item_history = BmetItemHistory.new
  end

  # Edit a specific BmetItemHistory
  def edit
  end

  # Create and save a new BmetItemHistory
  # to the database
  def create
    @item_history = BmetItemHistory.new(item_history_params)

    respond_to do |format|
      if @item_history.save
        format.html { redirect_to @item_history, notice: 'Item history was successfully created.' }
        format.json { render action: 'show', status: :created, location: @item_history }
      else
        format.html { render action: 'new' }
        format.json { render json: @item_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # Update a specific BmetItemHistory
  def update
    respond_to do |format|
      if @item_history.update(item_history_params)
        format.html { redirect_to @item_history, notice: 'Item history was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # Update a specific BmetItemHistory
  def destroy
    @item_history.destroy
    respond_to do |format|
      format.html { redirect_to bmet_item_histories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_history
      @item_history = BmetItemHistory.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_history_params
      params.require(:bmet_item_history).permit(:bmet_item_id, :bmet_item_condition, :bmet_item_status, :work_order_id, :work_order_status, :remarks)
    end
end
