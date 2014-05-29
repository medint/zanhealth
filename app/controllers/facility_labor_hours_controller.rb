class FacilityLaborHoursController < ApplicationController

  before_action :set_labor_hour, only: [:show, :edit, :update, :destroy]

  def index
    @facility_labor_hours=FacilityLaborHour.all
  end
  def new
    @facility_labor_hour = FacilityLaborHour.new
    #@users = User.where(:facility_id => user.facility.id).all.to_a
  end
  # POST /bmet_work_orders
  # POST /bmet_work_orders.json
  def create
    @facility_labor_hour = FacilityLaborHour.new(labor_hour_params)

    respond_to do |format|
      if @facility_labor_hour.save
        format.html { redirect_to :back, notice: 'Work order was successfully updated.' }
        format.json { render action: 'show', status: :created, location: @facility_labor_hour }
      else
        format.html { render action: 'new' }
        format.json { render json: @facility_labor_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @facility_labor_hour.update(labor_hour_params)
        format.html { redirect_to @facility_labor_hour.facility_work_order, notice: 'Facility Labor Hour was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @facility_labor_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @facility_labor_hour.destroy
    respond_to do |format|
      link = request.referer.split("/")[-2]
      @facility_work_order = @facility_labor_hour.facility_work_order
      if link == "hidden"
          format.html { redirect_to facility_work_orders_url+"/hidden/"+@facility_work_order.id.to_s, notice: 'Work order was successfully updated.' }
      elsif link == "all"
          format.html { redirect_to facility_work_orders_url+"/all/"+@facility_work_order.id.to_s, notice: 'Work order was successfully updated.' }
      else
          format.html { redirect_to facility_work_orders_url+"/unhidden/"+@facility_work_order.id.to_s, notice: 'Work order was successfully updated.' }
      end
      # format.html { redirect_to @facility_labor_hour.facility_work_order }
      format.json { head :no_content }
    end
  end

  def show      
      @facility_labor_hours=FacilityLaborHour.all
      #@facility_labor_hour=LaborHour.where(:id => params[:id])
  end

  private 
    def set_labor_hour
      @facility_labor_hour = FacilityLaborHour.find(params[:id])
    end
    def labor_hour_params
      params.require(:facility_labor_hour).permit(:date_started, :duration, :technician_id, :facility_work_order_id)
    end
    
end
