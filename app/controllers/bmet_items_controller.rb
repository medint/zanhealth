class BmetItemsController < ApplicationController
  layout 'layouts/bmet_app'
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_bmet_models, only: [:new, :show]
  before_action :set_departments, only: [:new, :show]

  # GET /items
  # GET /items.json
  def index
	   @bmet_items = BmetItem.includes(:bmet_model, {:department => :facility}).where("facilities.id=?", current_user.facility).references(:facility)
  end

  # GET /detailed_items
  def detailed
    @bmet_items = BmetItem.includes(:bmet_model, {:department => :facility}).where("facilities.id=?", current_user.facility).references(:facility)
  end

  # GET /items/1
  # GET /items/1.json
  def show
      @bmet_items = BmetItem.includes(:bmet_model, {:department => :facility}).where("facilities.id=?", current_user.facility).references(:facility)
	    @bmet_item_history = BmetItemHistory.where(:bmet_item_id => params[:id]).order(:created_at)
	    @latest_history = BmetItemHistory.order(:created_at).find_by bmet_item_id:params[:id]
  end

  # GET /items/new
  def new
    @bmet_items = BmetItem.includes(:bmet_model, {:department => :facility}).where("facilities.id=?", current_user.facility).references(:facility)
    @bmet_item = BmetItem.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @bmet_item = BmetItem.new(item_params)

    respond_to do |format|
      if @bmet_item.save
        format.html { redirect_to @bmet_item, notice: 'Item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bmet_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @bmet_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @bmet_item.update(item_params)
        format.html { redirect_to @bmet_item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bmet_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @bmet_item.destroy
    respond_to do |format|
      format.html { redirect_to bmet_items_url }
      format.json { head :no_content }
    end
  end

  def import
    BmetItem.import(params[:file])
    BmetModel.import(params[:file])
    redirect_to root_url, notice: "Items and associated models imported."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @bmet_item = BmetItem.find(params[:id])
    end

    def set_bmet_models
      @bmet_models = BmetModel.all
    end

    def set_departments
      @departments = Department.where(:facility_id => current_user.facility.id).all.to_a
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:bmet_item).permit(:asset_id, :bmet_model_id, :serial_number, :year_manufactured, :funding, :date_received, :warranty_expire, :contract_expire, :warranty_notes, :service_agent, :department_id, :location, :item_type, :price)
    end
end
