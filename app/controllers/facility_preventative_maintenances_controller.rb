class FacilityPreventativeMaintenancesController < ApplicationController
  layout 'layouts/facilities_app'
  before_action :set_facility_preventative_maintenance, only: [:show, :update, :destroy]
  before_action :set_facility_preventative_maintenances, only: [:show, :index, :new]  
  before_action :set_status, only: [:show]
  before_action :set_users, only: [:show]
  before_action :set_departments, only: [:show]

  def search
    @facility_preventative_maintenances = FacilityPreventativeMaintenance.search(params[:q]).records

    render action: "index"
  end

  def new    
    @facility_preventative_maintenance = FacilityPreventativeMaintenance.new

  end

  def index

  end

  def show
    @input_object = FacilityWorkOrder.new
    @input_object.description = @facility_preventative_maintenance.description
  end

  def update
    respond_to do |format|
      if @facility_preventative_maintenance.update(facility_preventative_maintenance_params)
        format.html { redirect_to @facility_preventative_maintenance, notice: 'Work request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @facility_preventative_maintenance.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @facility_preventative_maintenance = FacilityPreventativeMaintenance.new(facility_preventative_maintenance_params)

    respond_to do |format|
      if @facility_preventative_maintenance.save
        format.html { redirect_to @facility_preventative_maintenance, notice: 'Work order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @facility_preventative_maintenance }
      else
        format.html { render action: 'new' }
        format.json { render json: @facility_preventative_maintenance.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @facility_preventative_maintenance.destroy
    respond_to do |format|
      format.html { redirect_to facility_preventative_maintenances_url }
      format.json { head :no_content }
    end
  end

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

  def set_facility_preventative_maintenance
      @facility_preventative_maintenance = FacilityPreventativeMaintenance.find(params[:id])
      @facility_preventative_maintenance.calc_days_since # necessary because diff object from those inside pluralized PM object
  end

  def set_facility_preventative_maintenances
      @facility_preventative_maintenances = FacilityPreventativeMaintenance.all
      @facility_preventative_maintenances.map {|i| i.calc_days_since}  
  end

  def facility_preventative_maintenance_params
      params.require(:facility_preventative_maintenance).permit(:description, :last_date_checked, :days, :weeks, :months, :next_date, :created_at, :updated_at)
  end

end
