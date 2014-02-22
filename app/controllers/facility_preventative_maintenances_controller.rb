class FacilityPreventativeMaintenancesController < ApplicationController
  layout 'layouts/facilities_app'
  before_action :set_facility_preventative_maintenance, only: [:show, :update]

  def new
    @facility_preventative_maintenances = FacilityPreventativeMaintenance.all
    @facility_preventative_maintenance = FacilityPreventativeMaintenance.new
    @users = User.where(:facility_id => user.facility.id).all.to_a
  end

  def index
    @facility_preventative_maintenances = FacilityPreventativeMaintenance.all
  end

  def show

  	@facility_preventative_maintenances = FacilityPreventativeMaintenance.all
    @input_object = FacilityPreventativeMaintenance.new
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

  def set_facility_preventative_maintenance
      @facility_preventative_maintenance = FacilityPreventativeMaintenance.find(params[:id])
  end

  def facility_preventative_maintenance_params
      p params
      #params.require(:facility_preventative_maintenance).permit(:date_requested, :date_expire, :date_completed, :request_type, :item_id, :cost, :description, :status, :owner_id, :requester_id, :cause_description, :action_taken, :preventative_taken)
  end

end
