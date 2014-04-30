class BmetItemsController < ApplicationController
  layout 'layouts/bmet_app'
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
	@items = BmetItem.includes(:model, {:department => :facility}).where("facilities.id=?", current_user.facility).references(:facility)
  end

  # GET /detailed_items
  def detailed
    @items = BmetItem.includes(:model, {:department => :facility}).where("facilities.id=?", current_user.facility).references(:facility)
  end

  # GET /items/1
  # GET /items/1.json
  def show
	@item_history = BmetItemHistory.where(:bmet_item_id => params[:id]).order(:created_at)
	@latest_history = BmetItemHistory.order(:created_at).find_by bmet_item_id:params[:id]
  end

  # GET /items/new
  def new
    @item = BmetItem.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = BmetItem.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @item }
      else
        format.html { render action: 'new' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to bmet_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = BmetItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:bmet_item).permit(:asset_id, :model_id, :serial_number, :year_manufactured, :funding, :date_received, :warranty_expire, :contract_expire, :warranty_notes, :service_agent, :department_id, :location, :item_type, :price)
    end
end
