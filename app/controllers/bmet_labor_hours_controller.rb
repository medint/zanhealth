class BmetLaborHoursController < ApplicationController

	before_action :set_bmet_labor_hour, only: [:show, :edit, :update, :destroy]

  def index
  	@bmet_labor_hours=BmetLaborHour.all
  end
  def new
    @bmet_labor_hour = BmetLaborHour.new
    #@users = User.where(:facility_id => user.facility.id).all.to_a
  end
  # POST /bmet_work_orders
  # POST /bmet_work_orders.json
  def create
    @bmet_labor_hour = BmetLaborHour.new(bmet_labor_hour_params)

    respond_to do |format|
      if @bmet_labor_hour.save
        format.html { redirect_to @bmet_labor_hour.bmet_work_order, notice: 'Bmet Labor Hour was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bmet_labor_hour }
      else
        format.html { render action: 'new' }
        format.json { render json: @bmet_labor_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @bmet_labor_hour.update(bmet_labor_hour_params)
        format.html { redirect_to @bmet_labor_hour.bmet_work_order, notice: 'Bmet Labor Hour was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bmet_labor_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bmet_labor_hour.destroy
    respond_to do |format|
      format.html { redirect_to @bmet_labor_hour.bmet_work_order }
      format.json { head :no_content }
    end
  end

  def show      
      @bmet_labor_hours=BmetLaborHour.all
      #@bmet_labor_hour=LaborHour.where(:id => params[:id])
  end

 # Never trust parameters from the scary internet, only allow the white list through.
 	def set_bmet_labor_hour
      @bmet_labor_hour = BmetLaborHour.find(params[:id])
    end
    def bmet_labor_hour_params
      p params
      params.require(:bmet_labor_hour).permit(:date_started, :duration, :technician_id, :bmet_work_order_id)
    end

end
