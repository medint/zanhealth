class BmetWorkOrderCommentsController < ApplicationController
  load_and_authorize_resource
  before_action :set_bmet_work_order_comment, only: [:show, :edit, :update, :destroy]

  # GET /bmet_work_order_comments
  # GET /bmet_work_order_comments.json
  def index
    @bmet_work_order_comments = BmetWorkOrderComment.all
  end

  # GET /bmet_work_order_comments/1
  # GET /bmet_work_order_comments/1.json
  def show
  end

  # GET /bmet_work_order_comments/new
  def new
    @bmet_work_order_comment = BmetWorkOrderComment.new
  end

  # GET /bmet_work_order_comments/1/edit
  def edit
  end

  # POST /bmet_work_order_comments
  # POST /bmet_work_order_comments.json
  def create
    @bmet_work_order_comment = BmetWorkOrderComment.new(bmet_work_order_comment_params)
    @bmet_work_order_comment.user = current_user

    respond_to do |format|
      if @bmet_work_order_comment.save
        format.html { redirect_to  :back,  notice: 'Work request comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bmet_work_order_comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @bmet_work_order_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bmet_work_order_comments/1
  # PATCH/PUT /bmet_work_order_comments/1.json
  def update
    respond_to do |format|
      if @bmet_work_order_comment.update(bmet_work_order_comment_params)
        format.html { redirect_to @bmet_work_order_comment.bmet_work_order, notice: 'Work request comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bmet_work_order_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bmet_work_order_comments/1
  # DELETE /bmet_work_order_comments/1.json
  def destroy
    @bmet_work_order_comment.destroy
    respond_to do |format|
      link = request.referer.split("/")[-2]
      @bmet_work_order = @bmet_work_order_comment.bmet_work_order
      if link == "hidden"
          format.html { redirect_to bmet_work_orders_url+"/hidden/"+@bmet_work_order.id.to_s, notice: 'Work order was successfully updated.' }
      elsif link == "all"
          format.html { redirect_to bmet_work_orders_url+"/all/"+@bmet_work_order.id.to_s, notice: 'Work order was successfully updated.' }
      else
          format.html { redirect_to bmet_work_orders_url+"/unhidden/"+@bmet_work_order.id.to_s, notice: 'Work order was successfully updated.' }
      end
      # format.html { redirect_to @bmet_work_order_comment.bmet_work_order }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bmet_work_order_comment
      @bmet_work_order_comment = BmetWorkOrderComment.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bmet_work_order_comment_params
      params.require(:bmet_work_order_comment).permit(:datetime_stamp, :bmet_work_order_id, :user_id, :comment_text)
    end
end
