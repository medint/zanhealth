class WorkRequestCommentsController < ApplicationController
  before_action :set_work_request_comment, only: [:show, :edit, :update, :destroy]

  # GET /work_request_comments
  # GET /work_request_comments.json
  def index
    @work_request_comments = WorkRequestComment.all
  end

  # GET /work_request_comments/1
  # GET /work_request_comments/1.json
  def show
  end

  # GET /work_request_comments/new
  def new
    @work_request_comment = WorkRequestComment.new
  end

  # GET /work_request_comments/1/edit
  def edit
  end

  # POST /work_request_comments
  # POST /work_request_comments.json
  def create
    @work_request_comment = WorkRequestComment.new(work_request_comment_params)

    respond_to do |format|
      if @work_request_comment.save
        format.html { redirect_to @work_request_comment, notice: 'Work request comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @work_request_comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @work_request_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /work_request_comments/1
  # PATCH/PUT /work_request_comments/1.json
  def update
    respond_to do |format|
      if @work_request_comment.update(work_request_comment_params)
        format.html { redirect_to @work_request_comment, notice: 'Work request comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @work_request_comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work_request_comments/1
  # DELETE /work_request_comments/1.json
  def destroy
    @work_request_comment.destroy
    respond_to do |format|
      format.html { redirect_to work_request_comments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_request_comment
      @work_request_comment = WorkRequestComment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_request_comment_params
      params.require(:work_request_comment).permit(:datetime_stamp, :work_request_id, :user_id, :comment_text)
    end
end
