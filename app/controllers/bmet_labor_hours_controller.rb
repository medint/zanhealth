class BmetLaborHoursController < ApplicationController

	before_action :set_labor_hour, only: [:show, :edit, :update, :destroy]

  def index
  	@labor_hours=BmetLaborHour.all
  end
  def new
    @labor_hour = BmetLaborHour.new
    #@users = User.where(:facility_id => user.facility.id).all.to_a
  end
  # POST /bmet_work_orders
  # POST /bmet_work_orders.json
  def create
    @labor_hour = BmetLaborHour.new(labor_hour_params)

    respond_to do |format|
      if @labor_hour.save
        format.html { redirect_to @labor_hour, notice: 'Bmet Labor Hour was successfully created.' }
        format.json { render action: 'show', status: :created, location: @labor_hour }
      else
        format.html { render action: 'new' }
        format.json { render json: @labor_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @labor_hour.update(labor_hour_params)
        format.html { redirect_to @labor_hour, notice: 'Bmet Labor Hour was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @labor_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @labor_hour.destroy
    respond_to do |format|
      format.html { redirect_to bmet_work_order_url }
      format.json { head :no_content }
    end
  end

  def show      
      @labor_hours=BmetLaborHour.all
      #@labor_hour=LaborHour.where(:id => params[:id])
  end

 # Never trust parameters from the scary internet, only allow the white list through.
 	def set_labor_hour
      @labor_hour = BmetLaborHour.find(params[:id])
    end
    def labor_hour_params
      p params
      params.require(:bmet_labor_hour).permit(:date_started, :duration, :technician_id, :bmet_work_order_id)
    end

end
