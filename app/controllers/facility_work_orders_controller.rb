class FacilityWorkOrdersController < ApplicationController
  layout 'layouts/facilities_app'

  def new
  end

  def index
    @facility_work_orders = FacilityWorkOrder.all
  end
end
