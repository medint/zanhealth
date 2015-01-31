class BmetItemsController < ApplicationController
  layout 'layouts/bmet_app'
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_bmet_models, only: [:new, :show, :show_main_list_print, :show_main_list_print_by_department]
  before_action :set_departments, only: [:new, :show, :show_main_list_print, :show_main_list_print_by_department]
  before_action :set_bmet_items, only: [:index, :detailed, :show, :as_csv, :new, :show_main_list_print, :show_main_list_print_by_department]
  before_action :set_status, only: [:show, :new]
  before_action :set_conditions, only: [:show, :new]
  load_and_authorize_resource param_method: :item_params
  before_action :set_status_string_hash, only: [:show]
  before_action :set_conditions_string_hash, only: [:show]
  before_action :set_work_order_status_string_hash, only: [:show]
  before_action :set_staging_data, only: [:confirm_import]

  def search
  	  @bmet_items = BmetItem.search(params[:q], :size => 100).records
	  @bmet_items = @bmet_items.includes(:bmet_model, {:department => :facility}).where("facilities.id=?", current_user.facility).references(:facility).order(:asset_id)
	  render action: 'index'
  end

  # GET /items
  # GET /items.json
  def index
	
  end

  # GET /detailed_items
  def detailed
  end

  # GET /items/1
  # GET /items/1.json
  def show
	    @bmet_item_histories = BmetItemHistory.where(:bmet_item_id => params[:id]).order(:created_at)
	    #@latest_history = BmetItemHistory.order(:created_at).find_by bmet_item_id:params[:id]
  end

  def as_csv
      @bmet_items =BmetItem.includes({:bmet_model => :item_group}, {:department => :facility}).where("facilities.id=?", current_user.facility).references(:facility)

      send_data @bmet_items.as_csv, type: "text/csv", filename: "bmet_items.csv"

  end

  # GET /items/new
  def new
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

  def stage_import
    begin
      StagingModel.where(:facility_id => current_user.facility.id).destroy_all
      StagingItem.where(:facility_id => current_user.facility.id).destroy_all
      BmetModel.stage_import(params[:file], current_user.facility.id)
      BmetItem.stage_import(params[:file], current_user.facility.id)
      puts "show_red"
      puts params[:show_red]
      @show_red = params[:show_red]
      confirm_import
    #rescue
     # redirect_to bmet_items_path, notice: "Invalid CSV file format"
    end
  end

  def confirm_import
    @facility_id = current_user.facility.id
    render 'import_confirmation'
  end

  def import
    #begin
      BmetModel.import(current_user.facility.id)
      BmetItem.data_import(current_user.facility.id)
      redirect_to bmet_items_path, notice: "Items and associated models imported."
      #rescue
         #redirect_to :back, notice: "Invalid CSV file format."    
      #end
      StagingModel.destroy_all
      StagingItem.destroy_all
  end

  def cancel_import
    StagingModel.where(:facility_id => current_user.facility.id).delete_all
    StagingItem.where(:facility_id => current_user.facility.id).delete_all
    redirect_to bmet_items_url, notice: "Import cancelled"
  end 

  def show_main_list_print
    render 'main_list_print_view', layout: 'blank'
  end

  def show_import_page
    render 'import_page'
  end

  private
    # for edit/update since dropdown is in words but has to be sent as db to backend
    def set_status
      @status= {
        'Active' => 0,
        'Inactive' => 1,
        'Retired' => 2
      }
    end

    def set_conditions 
      @conditions = {
        'Poor' => 0,
        'Fair' => 1,
        'Good' => 2,
        'Very Good' => 3
      }
    end

    # for displaying since stored as integer in db
    def set_status_string_hash
      @status_string_hash = ['Active','Inactive','Retired']
    end

    def set_conditions_string_hash
      @conditions_string_hash = ['Poor','Fair','Good','Very Good']
    end

    def set_work_order_status_string_hash
      @wo_status_string_hash = ['Unstarted', 'In-progress', 'Completed']
    end

    def set_item
      @bmet_item = BmetItem.find_by_id(params[:id])
    end

    def set_bmet_models
      @bmet_models = BmetModel.where(:facility_id => current_user.facility.id).order(:manufacturer_name)
    end

    def set_departments
      @departments = Department.where(:facility_id => current_user.facility.id).order(:name).to_a
    end

    def set_bmet_items
      @bmet_items = BmetItem.includes(:bmet_model, {:department => :facility}).where("facilities.id=?", current_user.facility).references(:facility).order(:asset_id)
    end

    def set_staging_data
      @staging_items = StagingItem.all
      @staging_models = StagingModel.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:bmet_item).permit(:asset_id, :bmet_model_id, :serial_number, :year_manufactured, :funding, :date_received, :warranty_expire, :contract_expire, :warranty_notes, :service_agent, :department_id, :location, :price, :status, :condition, :notes, :show_red)
    end
end
