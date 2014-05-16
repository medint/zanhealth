class FacilityPreventativeMaintenancesController < ApplicationController
  layout 'layouts/facilities_app'
  before_action :set_facility_preventative_maintenance, only: [:show, :update, :destroy, :show_hidden, :show_all]
  before_action :set_facility_preventative_maintenances, only: [:show, :index, :new]   
  before_action :set_status, only: [:show, :show_hidden, :show_all]
  before_action :set_users, only: [:show, :hidden, :all, :show_hidden, :show_all]
  before_action :set_departments, only: [:show, :hidden, :all, :show_hidden, :show_all]
  before_action :set_hidden_facility_preventative_maintenances, only: [:hidden, :show_hidden]
  before_action :set_all_facility_preventative_maintenances, only:[:all, :show_all]

  def search
    @facility_preventative_maintenances = FacilityPreventativeMaintenance.search(params[:q]).records
    @facility_preventative_maintenances = @facility_preventative_maintenances.includes({:requester => :facility}).where("facilities.id=?", current_user.facility_id).references(:facility).all.to_a
    @link = facility_preventative_maintenances_url+"/all/"
    render action: "index"
  end

  def new
    @facility_preventative_maintenance = FacilityPreventativeMaintenance.new
  end

  def index
  	  @link = facility_preventative_maintenances_url+"/unhidden/"
  end

  def hidden
  	 @link = facility_preventative_maintenances_url+"/hidden/"
  	 render 'index'
  end

  def all
  	  @link = facility_preventative_maintenances_url+"/all/"
  	  render 'index'
  end

  def as_csv
  	@facility_preventative_maintenances = FacilityPreventativeMaintenance.with_deleted.includes({:requester => :facility}).where("facilities.id=?", current_user.facility_id).references(:facility)
  	  send_data @facility_preventative_maintenances.as_csv, type: "text/csv", filename:"facility_preventative_maintenances.csv"
  end

  def show
    @input_object = FacilityWorkOrder.new
    @input_object.description = @facility_preventative_maintenance.description
  end

  def show_hidden
    @input_object = FacilityWorkOrder.new
    @input_object.description = @facility_preventative_maintenance.description
    render 'show'
  end

  def show_all
    @input_object = FacilityWorkOrder.new
    @input_object.description = @facility_preventative_maintenance.description
    render 'show'
  end

  def update
    respond_to do |format|
    	link = request.referer.split("/")[-2]
      if @facility_preventative_maintenance.update(facility_preventative_maintenance_params)
      	if link == "hidden"
       	  format.html { redirect_to facility_preventative_maintenances_url+"/hidden/"+@facility_preventative_maintenance.id.to_s, notice: 'Work request was successfully updated.' }
  		  elsif link == "all"
       	  format.html { redirect_to facility_preventative_maintenances_url+"/all/"+@facility_preventative_maintenance.id.to_s, notice: 'Work request was successfully updated.' }
  		  else
         	format.html { redirect_to facility_preventative_maintenances_url+"/unhidden/"+@facility_preventative_maintenance.id.to_s, notice: 'Work request was successfully updated.' }
  		  end
        format.json { head :no_content }
      else
        format.html { redirect_to :back }
        format.json { render json: @facility_preventative_maintenance.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @facility_preventative_maintenance = FacilityPreventativeMaintenance.new(facility_preventative_maintenance_params)
    @facility_preventative_maintenance.requester_id = current_user.id

    respond_to do |format|
      if @facility_preventative_maintenance.save
        format.html { redirect_to facility_preventative_maintenances_url+"/unhidden/"+@facility_preventative_maintenance.id.to_s, notice: 'Work order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @facility_preventative_maintenance }
      else
        format.html { redirect_to :back }
        format.json { render json: @facility_preventative_maintenance.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @facility_preventative_maintenance.really_destroy!
    respond_to do |format|
      format.html { redirect_to facility_preventative_maintenances_url }
      format.json { head :no_content }
    end
  end

  def hide
  	  @facility_preventative_maintenance = FacilityPreventativeMaintenance.with_deleted.find(params[:id])
  	  if @facility_preventative_maintenance.destroyed?
  	  	  FacilityPreventativeMaintenance.restore(@facility_preventative_maintenance.id)
	  else
	  	  @facility_preventative_maintenance.destroy
	  end
	  respond_to do |format|
	  	  link = "/"+request.referer.split("/")[-2]
	  	  if link == "/all"
	  	  	  format.html { redirect_to request.referer }
		  else
		  	  link = facility_preventative_maintenances_url+link
		  	  format.html { redirect_to link }
		  end
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
    @users = User.where(:facility_id => current_user.facility_id).all.to_a
  end

  def set_departments
    @departments = Department.where(:facility_id => current_user.facility_id).all.to_a
  end

  def set_facility_preventative_maintenance
      @facility_preventative_maintenance = FacilityPreventativeMaintenance.with_deleted.find_by_id(params[:id])
      if (@facility_preventative_maintenance==nil || @facility_preventative_maintenance.requester.facility_id!=current_user.facility_id)
        @facility_preventative_maintenance=nil
        redirect_to "/404"
      else
        @facility_preventative_maintenance.calc_days_since # necessary because diff object from those inside pluralized PM object
      end
  end

  def set_facility_preventative_maintenances
      @facility_preventative_maintenances = FacilityPreventativeMaintenance.includes({:requester => :facility}).where("facilities.id=?", current_user.facility_id).references(:facility).all.to_a
      @facility_preventative_maintenances.map {|i| i.calc_days_since}  
  end

  def set_hidden_facility_preventative_maintenances
  	@facility_preventative_maintenances = FacilityPreventativeMaintenance.only_deleted.includes({:requester => :facility}).where("facilities.id=?", current_user.facility_id).references(:facility).all.to_a
  	@facility_preventative_maintenances.map {|i| i.calc_days_since}
  end

  def set_all_facility_preventative_maintenances
  	@facility_preventative_maintenances = FacilityPreventativeMaintenance.with_deleted.includes({:requester => :facility}).where("facilities.id=?", current_user.facility_id).references(:facility).all.to_a
  	@facility_preventative_maintenances.map {|i| i.calc_days_since}
  end

  def facility_preventative_maintenance_params
      params.require(:facility_preventative_maintenance).permit(:description, :last_date_checked, :days, :weeks, :months, :next_date, :created_at, :updated_at, :requester_id)
  end

end
