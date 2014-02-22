class FacilityWorkOrdersController < ApplicationController
  layout 'layouts/facilities_app'
  before_action :set_facility_work_order, only: [:show, :update]

  def new
  end

  def index
    @facility_work_orders = FacilityWorkOrder.all
  end

  def show
  	@facility_work_orders = FacilityWorkOrder.all
  	@facility_work_order = FacilityWorkOrder.find(params[:id])
  	#@users = User.where(:facility_id => facility.id).all.to_a

  end

  def update
    respond_to do |format|
      if @facility_work_order.update(facility_work_order_params)
        format.html { redirect_to @facility_work_order, notice: 'Work request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @facility_work_order.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_facility_work_order
      @facility_work_order = FacilityWorkOrder.find(params[:id])
  end

  def facility_work_order_params
      p params
      params.require(:facility_work_order).permit(:date_requested, :date_expire, :date_completed, :request_type, :item_id, :cost, :description, :status, :owner_id, :requester_id, :cause_description, :action_taken, :prevention_taken)
  end
end
