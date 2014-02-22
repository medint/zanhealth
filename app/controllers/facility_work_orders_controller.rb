class FacilityWorkOrdersController < ApplicationController
  layout 'layouts/facilities_app'

  def new
  end

  def index
    @facility_work_orders = FacilityWorkOrder.all
  end

  def show
    @facility_work_orders = FacilityWorkOrder.all
  	@facility_work_order = FacilityWorkOrder.find(params[:id])
    @facility_work_order_comments = FacilityWorkOrderComment.where(work_order_id:params[:id])
    @facility_costs = FacilityCost.where(work_order_id:params[:id])
    @facility_labor_hours = FacilityLaborHour.where(work_order_id:params[:id])
  end
end
