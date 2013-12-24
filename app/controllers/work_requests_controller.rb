class WorkRequestsController < ApplicationController
  before_action :set_work_request, only: [:show, :edit, :update, :destroy]

  # GET /work_requests
  # GET /work_requests.json
  def index
    @work_requests = WorkRequest.all.to_a.select do |work_request|
      user.facility == work_request.item.location.facility
    end
  end

  # GET /work_requests/1
  # GET /work_requests/1.json
  def show
  	  @work_requests = WorkRequest.find(:id)
  	  @wr_comment - WorkRequestComment.all
  end

  # GET /work_requests/new
  def new
    @work_request = WorkRequest.new
  end

  # GET /work_requests/1/edit
  def edit
  end

  # POST /work_requests
  # POST /work_requests.json
  def create
    @work_request = WorkRequest.new(work_request_params)

    respond_to do |format|
      if @work_request.save
        format.html { redirect_to @work_request, notice: 'Work request was successfully created.' }
        format.json { render action: 'show', status: :created, location: @work_request }
      else
        format.html { render action: 'new' }
        format.json { render json: @work_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /work_requests/1
  # PATCH/PUT /work_requests/1.json
  def update
    respond_to do |format|
      if @work_request.update(work_request_params)
        format.html { redirect_to @work_request, notice: 'Work request was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @work_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work_requests/1
  # DELETE /work_requests/1.json
  def destroy
    @work_request.destroy
    respond_to do |format|
      format.html { redirect_to work_requests_url }
      format.json { head :no_content }
    end
  end

  def my
    @work_requests = WorkRequest.where(owner_id: user.id)
    @texts = Text.all.to_a.select do |text|
      user.facility == text.work_request.item.location.facility
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_request
      @work_request = WorkRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_request_params
      params.require(:work_request).permit(:date_requested, :date_expire, :date_completed, :request_type, :item, :cost, :description, :status, :owner_id, :requester_id, :cause_description, :action_taken, :prevention_taken)
    end
end
