class FacilityPreventativeMaintenancesController < ApplicationController
  layout 'layouts/facilities_app'
  before_action :set_facility_preventative_maintenance, only: [:show, :update]

  def new

    @facility_preventative_maintenances = FacilityPreventativeMaintenance.all
    @facility_preventative_maintenance = FacilityPreventativeMaintenance.new
    #@users = User.where(:facility_id => user.facility.id).all.to_a

  end

  def index
    @facility_preventative_maintenances = FacilityPreventativeMaintenance.all
  end

  def show


    @facility_preventative_maintenances = FacilityPreventativeMaintenance.all

    #@facility_preventative_maintenance_comments = FacilityPreventativeMaintenancesComment.where(preventative_maintenance_id:params[:id])
    #@facility_costs = FacilityCost.where(preventative_maintenance_id:params[:id])
    #@facility_labor_hours = FacilityLaborHour.where(preventative_maintenance_id:params[:id])

    @input_object = FacilityWorkOrder.new
    #@facility_preventative_maintenance_comments = FacilityPreventativeMaintenancesComment.where(work_order_id:params[:id])
    #@facility_costs = FacilityCost.where(work_order_id:params[:id])
    #@facility_labor_hours = FacilityLaborHour.where(work_order_id:params[:id])

  	#@users = User.where(:facility_id => facility.id).all.to_a

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

  def set_facility_preventative_maintenance
      @facility_preventative_maintenance = FacilityPreventativeMaintenance.find(params[:id])
  end

  def facility_preventative_maintenance_params
      p params
      params.require(:facility_preventative_maintenance).permit(:last_date_checked, :days, :weeks, :months, :next_date, :created_at, :updated_at)
  end

end
