class FacilityWorkOrderCommentsController < ApplicationController
  before_action :set_facility_work_order_comment, only: [:show, :edit, :update, :destroy]

  # GET /facility_work_order_comments
  # GET /facility_work_order_comments.json
  def index
    @facility_work_order_comments = FacilityWorkOrderComment.all
  end

  # GET /facility_work_order_comments/1
  # GET /facility_work_order_comments/1.json
  def show
  end

  # GET /facility_work_order_comments/new
  def new
    @facility_work_order_comment = FacilityWorkOrderComment.new
  end

  # GET /facility_work_order_comments/1/edit
  def edit
  end

  # POST /facility_work_order_comments
  # POST /facility_work_order_comments.json
  def create
    @facility_work_order_comment = FacilityWorkOrderComment.new(facility_work_order_comment_params)
    
    respond_to do |format|
      if @facility_work_order_comment.save
        format.html { redirect_to @facility_work_order_comment.facility_work_order, notice: 'Facility Work Order comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @facility_work_order_comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @facility_work_order_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /facility_work_order_comments/1
  # PATCH/PUT /facility_work_order_comments/1.json
  def update
    respond_to do |format|
      if @facility_work_order_comment.update(facility_work_order_comment_params)
        format.html { redirect_to @facility_work_order_comment, notice: 'Facility Work Order comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @facility_work_order_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facility_work_order_comments/1
  # DELETE /facility_work_order_comments/1.json
  def destroy
    @facility_work_order_comment.destroy
    respond_to do |format|
      format.html { redirect_to facility_work_order_comments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_facility_work_order_comment
      @facility_work_order_comment = FacilityWorkOrderComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def facility_work_order_comment_params
      params.require(:facility_work_order_comment).permit(:datetime_stamp, :facility_work_order_id, :user_id, :comment_text)
    end
end
