class FacilityWorkOrdersController < ApplicationController
  layout 'layouts/facilities_app'

  def new
  end

  def index
  end

  def show
  	@facility_work_order = FacilityWorkOrder.find(params[:id])
  end
end
