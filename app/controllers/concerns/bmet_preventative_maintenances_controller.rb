
class BmetPreventativeMaintenancesController < ApplicationController
  layout 'layouts/facilities_app'
  before_action :set_bmet_preventative_maintenance, only: [:show, :update, :destroy]
  before_action :set_status, only: [:show]
  before_action :set_users, only: [:show]
  before_action :set_departments, only: [:show]

  def search
    @bmet_preventative_maintenances = BmetPreventativeMaintenance.search(params[:q]).records

    render action: "index"
  end

  def new

    @bmet_preventative_maintenances = BmetPreventativeMaintenance.all
    @bmet_preventative_maintenances.map {|i| i.calc_days_since}
    @bmet_preventative_maintenance = BmetPreventativeMaintenance.new

  end

  def index
    @bmet_preventative_maintenances = BmetPreventativeMaintenance.all 
    @bmet_preventative_maintenances.map {|i| i.calc_days_since}
    
  end

  def show


    @bmet_preventative_maintenances = BmetPreventativeMaintenance.all
    @bmet_preventative_maintenances.map {|i| i.calc_days_since}
    
    @input_object = BmetWorkOrder.new
    @input_object.description = @bmet_preventative_maintenance.description

  end

  def update
    respond_to do |format|
      if @bmet_preventative_maintenance.update(bmet_preventative_maintenance_params)
        format.html { redirect_to @bmet_preventative_maintenance, notice: 'Work request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bmet_preventative_maintenance.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @bmet_preventative_maintenance = BmetPreventativeMaintenance.new(bmet_preventative_maintenance_params)

    respond_to do |format|
      if @bmet_preventative_maintenance.save
        format.html { redirect_to @bmet_preventative_maintenance, notice: 'Work order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bmet_preventative_maintenance }
      else
        format.html { render action: 'new' }
        format.json { render json: @bmet_preventative_maintenance.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bmet_preventative_maintenance.destroy
    respond_to do |format|
      format.html { redirect_to bmet_preventative_maintenances_url }
      format.json { head :no_content }
    end
  end

  def set_status
    @status= {
      'Unstarted' => 0,
      'In Progress' => 1,
      'Completed' => 2
    }
  end

  def set_users
    @users = User.where(:bmet_id => current_user.bmet_id).all.to_a
  end

  def set_departments
    @departments = Department.where(:bmet_id => current_user.bmet_id).all.to_a
  end

  def set_bmet_preventative_maintenance
      @bmet_preventative_maintenance = BmetPreventativeMaintenance.find(params[:id])
      @bmet_preventative_maintenance.calc_days_since # necessary because diff object from those inside pluralized PM object
  end


  def bmet_preventative_maintenance_params
      params.require(:bmet_preventative_maintenance).permit(:description, :last_date_checked, :days, :weeks, :months, :next_date, :created_at, :updated_at)
  end

end