class TextsController < ApplicationController
  before_action :set_text, only: [:show, :edit, :update, :destroy, :receive]

  # GET /texts
  # GET /texts.json
  def index
    @texts = Text.all
  end

  # GET /texts/1
  # GET /texts/1.json
  def show
  end

  # GET /texts/new
  def new
    @text = Text.new
  end
  
  def receive
    puts "Hello, logs!"
	message_body = params["Body"]
    from_number = params["From"]
	message = message_body.split("#")
	if message.first == "item"
		request = BmetWorkOrder.create(:id => message_body.second)
		BmetWorkOrderComment.create(:bmet_work_order_id => request.id,:comment_text => message.third)
	else
		comment = BmetWorkOrderComment.create(:bmet_work_order_id => message.second, :comment_text => message.fourth)
		#if comment.bmet_work_order.status != message.third
			#comment.bmet_work_order.status => message.third
		#end
	end
    SMSLogger.log_text_message from_number, message_body
  end


  # GET /texts/1/edit
  def edit
  end

  # POST /texts
  # POST /texts.json
  def create
    @text = Text.new(text_params)

    respond_to do |format|
      if @text.save
        format.html { redirect_to @text, notice: 'Text was successfully created.' }
        format.json { render action: 'show', status: :created, location: @text }
      else
        format.html { render action: 'new' }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /texts/1
  # PATCH/PUT /texts/1.json
  def update
    respond_to do |format|
      if @text.update(text_params)
        format.html { redirect_to @text, notice: 'Text was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /texts/1
  # DELETE /texts/1.json
  def destroy
    @text.destroy
    respond_to do |format|
      format.html { redirect_to texts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_text
      @text = Text.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def text_params
      params.require(:text).permit(:content, :number, :bmet_work_order_id, :receive)
    end
end
