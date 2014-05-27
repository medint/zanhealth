class BmetPreventativeMaintenancesController < ApplicationController
  layout 'layouts/bmet_app'
  before_action :set_bmet_preventative_maintenance, only: [:show, :edit, :update, :destroy, :show_all, :show_hidden]
  before_action :set_bmet_preventative_maintenances, only: [:show, :index, :new]
  before_action :set_status, only: [:show, :all, :hidden, :show_all, :show_hidden]
  before_action :set_users, only: [:show, :all, :hidden, :show_all, :show_hidden]
  before_action :set_departments, only: [:show, :all, :hidden, :show_all, :show_hidden]
  before_action :set_hidden_bmet_preventative_maintenances, only: [:hidden, :show_hidden]
  before_action :set_all_bmet_preventative_maintenances, only: [:all, :show_all]
  before_action :set_convert_object, only: [:show, :show_all, :show_hidden]

  # GET /bmet_preventative_maintenances
  # GET /bmet_preventative_maintenances.json
  def index
    @link = bmet_preventative_maintenances_url+'/unhidden/'
  end

  def hidden
  	  @link = bmet_preventative_maintenances_url+'/hidden/'
  	  render 'index'
  end

  def all
  	  @link = bmet_preventative_maintenances_url+'/all/'
  	  render 'index'
  end

  def as_csv
    @bmet_preventative_maintenances = BmetPreventativeMaintenance.with_deleted.includes({:requester => :facility}).where("facilities.id=?", current_user.facility_id).references(:facility)
      send_data @bmet_preventative_maintenances.as_csv, type: "text/csv", filename:"bmet_preventative_maintenances.csv"
  end

  # GET /bmet_preventative_maintenances/1
  # GET /bmet_preventative_maintenances/1.json
  def show
  end

  def show_hidden
  	  render 'show'
  end

  def show_all
  	  render 'show'
  end

  # GET /bmet_preventative_maintenances/new
  def new
    @bmet_preventative_maintenance = BmetPreventativeMaintenance.new
  end

  # GET /bmet_preventative_maintenances/1/edit
  def edit
  end

  # POST /bmet_preventative_maintenances
  # POST /bmet_preventative_maintenances.json
  def create
    @bmet_preventative_maintenance = BmetPreventativeMaintenance.new(bmet_preventative_maintenance_params)
    @bmet_preventative_maintenance.requester_id = current_user.id

    respond_to do |format|
      if @bmet_preventative_maintenance.save
        format.html { redirect_to bmet_preventative_maintenances_url+"/unhidden/"+@bmet_preventative_maintenance.id.to_s, notice: 'Bmet preventative maintenance was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bmet_preventative_maintenance }
      else
        format.html { redirect_to :back }
        format.json { render json: @bmet_preventative_maintenance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bmet_preventative_maintenances/1
  # PATCH/PUT /bmet_preventative_maintenances/1.json
  def update
    respond_to do |format|
      if @bmet_preventative_maintenance.update(bmet_preventative_maintenance_params)
      	  link = request.referer.split("/")[-2]
      	  if link == "hidden"
        	format.html { redirect_to bmet_preventative_maintenances_url+"/hidden/"+@bmet_preventative_maintenance.id.to_s, notice: 'Bmet preventative maintenance was successfully updated.' }
		  elsif link == "all"
        	format.html { redirect_to bmet_preventative_maintenances_url+"/all/"+@bmet_preventative_maintenance.id.to_s, notice: 'Bmet preventative maintenance was successfully updated.' }
		  else
        	format.html { redirect_to bmet_preventative_maintenances_url+"/unhidden/"+@bmet_preventative_maintenance.id.to_s, notice: 'Bmet preventative maintenance was successfully updated.' }
		  end
        format.json { head :no_content }
      else
        format.html { render :back }
        format.json { render json: @bmet_preventative_maintenance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bmet_preventative_maintenances/1
  # DELETE /bmet_preventative_maintenances/1.json
  def destroy
    @bmet_preventative_maintenance.really_destroy!
    respond_to do |format|
      format.html { redirect_to bmet_preventative_maintenances_url }
      format.json { head :no_content }
    end
  end

  def hide
  	  @bmet_preventative_maintenance = BmetPreventativeMaintenance.with_deleted.find(params[:id])
  	  if @bmet_preventative_maintenance.destroyed?
  	  	  BmetPreventativeMaintenance.restore(@bmet_preventative_maintenance)
	  else
	  	  @bmet_preventative_maintenance.destroy
	  end
	  respond_to do |format|
	  	  link = "/"+request.referer.split("/")[-2]
	  	  if link == "/all"
	  	  	  format.html { redirect_to request.referer }
		  else
		  	  link = bmet_preventative_maintenances_url+link
		  	  format.html { redirect_to link }
		  end
		  format.json { head :no_content }
	  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
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

    def set_bmet_preventative_maintenance

      @bmet_preventative_maintenance = BmetPreventativeMaintenance.with_deleted.find(params[:id])
      if (@bmet_preventative_maintenance==nil || @bmet_preventative_maintenance.requester.facility_id!=current_user.facility_id)
        @bmet_preventative_maintenance=nil
        redirect_to "/404"
      else
        @bmet_preventative_maintenance.calc_days_since # necessary because diff object from those inside pluralized PM object
      end      
    end

    def set_bmet_preventative_maintenances
      @bmet_preventative_maintenances = BmetPreventativeMaintenance.includes({:requester => :facility}).where("facilities.id=?", current_user.facility_id).references(:facility).all.to_a
      @bmet_preventative_maintenances.map {|i| i.calc_days_since}        
    end

    def set_hidden_bmet_preventative_maintenances
    	@bmet_preventative_maintenances = BmetPreventativeMaintenance.only_deleted.includes({:requester => :facility}).where("facilities.id=?", current_user.facility_id).references(:facility).all.to_a
    	@bmet_preventative_maintenances.map {|i| i.calc_days_since }
	end

	def set_all_bmet_preventative_maintenances
		@bmet_preventative_maintenances = BmetPreventativeMaintenance.with_deleted.includes({:requester => :facility}).where("facilities.id=?", current_user.facility_id).references(:facility).all.to_a
		@bmet_preventative_maintenances.map {|i| i.calc_days_since }
	end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bmet_preventative_maintenance_params
      params.require(:bmet_preventative_maintenance).permit(:late_date_checked, :days, :weeks, :months, :next_date, :description)
    end

    def set_convert_object
      @input_object = BmetWorkOrder.new
      @input_object.wr_origin = nil
      @input_object.pm_origin = @bmet_preventative_maintenance.id
      @input_object.description = @bmet_preventative_maintenance.description
    end

end
