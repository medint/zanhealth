class BmetWorkRequestsController < ApplicationController
  before_action :set_bmet_work_request, only: [:show, :edit, :update, :destroy]

  # GET /bmet_work_requests
  # GET /bmet_work_requests.json
  def index
    @bmet_work_requests = BmetWorkRequest.all
  end

  # GET /bmet_work_requests/1
  # GET /bmet_work_requests/1.json
  def show
  end

  # GET /bmet_work_requests/new
  def new
    @bmet_work_request = BmetWorkRequest.new
  end

  # GET /bmet_work_requests/1/edit
  def edit
  end

  # POST /bmet_work_requests
  # POST /bmet_work_requests.json
  def create
    @bmet_work_request = BmetWorkRequest.new(bmet_work_request_params)

    respond_to do |format|
      if @bmet_work_request.save
        format.html { redirect_to @bmet_work_request, notice: 'Bmet work request was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bmet_work_request }
      else
        format.html { render action: 'new' }
        format.json { render json: @bmet_work_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bmet_work_requests/1
  # PATCH/PUT /bmet_work_requests/1.json
  def update
    respond_to do |format|
      if @bmet_work_request.update(bmet_work_request_params)
        format.html { redirect_to @bmet_work_request, notice: 'Bmet work request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bmet_work_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bmet_work_requests/1
  # DELETE /bmet_work_requests/1.json
  def destroy
    @bmet_work_request.destroy
    respond_to do |format|
      format.html { redirect_to bmet_work_requests_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bmet_work_request
      @bmet_work_request = BmetWorkRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bmet_work_request_params
      params.require(:bmet_work_request).permit(:requester, :department, :location, :phone, :email, :description)
    end
end
