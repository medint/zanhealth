class FacilityWorkOrdersController < ApplicationController
  layout 'layouts/facilities_app'

  def new
  end

  def index
    @facility_work_orders = FacilityWorkOrder.all
  end

  def show
  	@facility_work_order = FacilityWorkOrder.find(params[:id])
  end
end
