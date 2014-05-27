class FacilityWorkRequestsController < ApplicationController
  load_and_authorize_resource :except => [:public_new, :public_create, :public_show]
before_action :set_facility_work_request, only: [:show, :update, :destroy, :edit, :show_hidden, :show_all]
before_action :set_facility_work_requests, only:[:new, :index, :show, :search]
before_action :set_status, only: [:show, :hidden, :all, :show_all, :show_hidden]
before_action :set_users, only: [:show, :hidden, :all, :show_all, :show_hidden], except: [:new, :create]
before_action :set_departments, only: [:show, :hidden, :all, :show_all, :show_hidden]
before_action :set_hidden_facility_work_requests, only: [:hidden, :show_hidden]
before_action :set_all_facility_work_requests, only: [:all, :show_all]
before_action :set_convert_object, only: [:show, :show_all, :show_hidden]
skip_before_action :authenticate_user!, only: [:public_new, :public_create, :public_show]

  layout 'layouts/facilities_app'

  def search
    @facility_work_requests = FacilityWorkRequest.search(params[:q]).records
    @facility_work_requests = @facility_work_requests.where(:facility_id => current_user.facility_id).all.to_a
    @link = facility_work_requests_url+"/all/"
    render action: "index"
  end

  def new
    @facility_work_request = FacilityWorkRequest.new
  end

  def edit
  end

  def as_csv
    @facility_work_requests = FacilityWorkRequest.with_deleted.where(:facility_id => current_user.facility_id)
    send_data @facility_work_requests.as_csv, type: "text/csv", filename: "facility_work_requests.csv"
  end

  def index
  	  @link = facility_work_requests_url+"/unhidden/"
  end

  def hidden
  	  @link = facility_work_requests_url+"/hidden/"
  	  render 'index'
  end

  def all
  	  @link = facility_work_requests_url+"/all/"
  	  render 'index'
  end

  def show

  end

  def show_hidden
 	 	render 'show'
  end
 
  def show_all  	
 	  render 'show'
  end

  def update
    respond_to do |format|
      if @facility_work_request.update(facility_work_request_params)
      	link = request.referer.split("/")[-2]
      	if link == "hidden"
      		format.html { redirect_to facility_work_requests_url+"/hidden/"+@facility_work_request.id.to_s, notice: 'Work request was successfully updated. ' }
		elsif link == "all"
      		format.html { redirect_to facility_work_requests_url+"/all/"+@facility_work_request.id.to_s, notice: 'Work request was successfully updated. ' }
      	else
      		format.html { redirect_to facility_work_requests_url+"/unhidden/"+@facility_work_request.id.to_s, notice: 'Work request was successfully updated. ' }
		end
        format.json { head :no_content }
      else
        format.html { redirect_to :back }
        format.json { render json: @facility_work_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @facility_work_request = FacilityWorkRequest.new(facility_work_request_params)
    @facility_work_request.facility_id=current_user.facility_id

    respond_to do |format|
      if @facility_work_request.save
        format.html { redirect_to facility_work_requests_url+"/unhidden/"+@facility_work_request.id.to_s, notice: 'Work request was successfully created.' }
        format.json { render action: 'show', status: :created, location: @facility_work_request }
      else
        format.html { redirect_to :back }
        format.json { render json: @facility_work_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def public_new    
    @facility_work_request = FacilityWorkRequest.new
    @facility_work_request.facility_id = params[:facility_id]
    render :layout => "application"
  end

  def public_create    
    @facility_work_request = FacilityWorkRequest.new(facility_work_request_params)

    respond_to do |format|
      if verify_recaptcha(private_key: ENV['RECAPTCHA_PRIVATE_KEY']) && @facility_work_request.save
        format.html { redirect_to '/facility_work_requests/public_show/'+@facility_work_request.id.to_s, notice: 'Work order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @facility_work_request }
      else
        format.html { render action: 'public_new', layout: "application" }
        format.json { render json: @facility_work_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def public_show
    @facility_work_request = FacilityWorkRequest.find_by_id(params[:id])
    render :layout => "application"
  end

  def destroy
    @facility_work_request.really_destroy!
    respond_to do |format|
      format.html { redirect_to facility_work_requests_url }
      format.json { head :no_content }
    end
  end

  def hide
  	@facility_work_request = FacilityWorkRequest.with_deleted.find(params[:id])
  	if @facility_work_request.destroyed?
  		FacilityWorkRequest.restore(@facility_work_request.id)
	else
		@facility_work_request.destroy
	end
	respond_to do |format|
		link = "/"+request.referer.split("/")[-2]
		if link == "/all"
			format.html { redirect_to request.referer }
		else
			link = facility_work_requests_url+link
			format.html { redirect_to link }
		end
		format.json { head :no_content }
	end
  end

  private 
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

    def set_facility_work_request
      @facility_work_request = FacilityWorkRequest.with_deleted.find_by_id(params[:id])
      if (@facility_work_request==nil || @facility_work_request.facility_id!=current_user.facility_id)
          @facility_work_request=nil
          redirect_to "/404"
      end
    end

    def set_facility_work_requests
      @facility_work_requests = FacilityWorkRequest.where(:facility_id => current_user.facility_id).all.to_a
    end

   def set_hidden_facility_work_requests
      @facility_work_requests = FacilityWorkRequest.only_deleted.where(:facility_id => current_user.facility_id).all.to_a
    end

    def set_all_facility_work_requests
      @facility_work_requests = FacilityWorkRequest.with_deleted.where(:facility_id => current_user.facility_id).all.to_a
    end

    def facility_work_request_params
      params.require(:facility_work_request).permit(:id, :requester, :department, :location, :phone, :email, :description, :created_at, :updated_at, :facility_id)
    end

    def set_convert_object
      @input_object = FacilityWorkOrder.new
      @input_object.description = "Description: "+ @facility_work_request.description + "\n"+
      "Location: "+@facility_work_request.location + "\n" +
      "Email: "+@facility_work_request.email + "\n" +
      "Phone: "+@facility_work_request.phone + "\n"
      @input_object.pm_origin = nil
      @input_object.wr_origin = @facility_work_request.id
    end
    
end
