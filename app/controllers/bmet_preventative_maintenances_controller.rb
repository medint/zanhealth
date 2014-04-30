class BmetPreventativeMaintenancesController < ApplicationController
  layout 'layouts/bmet_app'
  before_action :set_bmet_preventative_maintenance, only: [:show, :edit, :update, :destroy]
  before_action :set_bmet_preventative_maintenances, only: [:show, :index, :new]
  before_action :set_status, only: [:show]
  before_action :set_users, only: [:show]
  before_action :set_departments, only: [:show]

  # GET /bmet_preventative_maintenances
  # GET /bmet_preventative_maintenances.json
  def index
    
  end

  # GET /bmet_preventative_maintenances/1
  # GET /bmet_preventative_maintenances/1.json
  def show
    @input_object = BmetWorkOrder.new
    @input_object.description = @bmet_preventative_maintenance.description
  end

  # GET /bmet_preventative_maintenances/new
  def new
    @bmet_preventative_maintenance = BmetPreventativeMaintenance.new
  end

  # GET /bmet_preventative_maintenances/1/edit
  def edit
  end

  # POST /bmet_preventative_maintenances
  # POST /bmet_preventative_maintenances.json
  def create
    @bmet_preventative_maintenance = BmetPreventativeMaintenance.new(bmet_preventative_maintenance_params)

    respond_to do |format|
      if @bmet_preventative_maintenance.save
        format.html { redirect_to @bmet_preventative_maintenance, notice: 'Bmet preventative maintenance was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bmet_preventative_maintenance }
      else
        format.html { render action: 'new' }
        format.json { render json: @bmet_preventative_maintenance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bmet_preventative_maintenances/1
  # PATCH/PUT /bmet_preventative_maintenances/1.json
  def update
    respond_to do |format|
      if @bmet_preventative_maintenance.update(bmet_preventative_maintenance_params)
        format.html { redirect_to @bmet_preventative_maintenance, notice: 'Bmet preventative maintenance was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bmet_preventative_maintenance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bmet_preventative_maintenances/1
  # DELETE /bmet_preventative_maintenances/1.json
  def destroy
    @bmet_preventative_maintenance.destroy
    respond_to do |format|
      format.html { redirect_to bmet_preventative_maintenances_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status= {
        'Unstarted' => 0,
        'In Progress' => 1,
        'Completed' => 2
      }
    end

    def set_users
      @users = User.where(:facility_id => current_user.facility_id).all.to_a
    end

    def set_departments
      @departments = Department.where(:facility_id => current_user.facility_id).all.to_a
    end

    def set_bmet_preventative_maintenance
      @bmet_preventative_maintenance = BmetPreventativeMaintenance.find(params[:id])
      @bmet_preventative_maintenance.calc_days_since # necessary because diff object from those inside pluralized PM object
    end

    def set_bmet_preventative_maintenances
      @bmet_preventative_maintenances = BmetPreventativeMaintenance.all
      @bmet_preventative_maintenances.map {|i| i.calc_days_since}  
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bmet_preventative_maintenance_params
      params.require(:bmet_preventative_maintenance).permit(:late_date_checked, :days, :weeks, :months, :next_date, :description)
    end
end
