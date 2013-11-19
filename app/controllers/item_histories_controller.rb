class ItemHistoriesController < ApplicationController
  before_action :set_item_history, only: [:show, :edit, :update, :destroy]

  # GET /item_histories
  # GET /item_histories.json
  def index
    @item_histories = ItemHistory.all
  end

  # GET /item_histories/1
  # GET /item_histories/1.json
  def show
  end

  # GET /item_histories/new
  def new
    @item_history = ItemHistory.new
  end

  # GET /item_histories/1/edit
  def edit
  end

  # POST /item_histories
  # POST /item_histories.json
  def create
    @item_history = ItemHistory.new(item_history_params)

    respond_to do |format|
      if @item_history.save
        format.html { redirect_to @item_history, notice: 'Item history was successfully created.' }
        format.json { render action: 'show', status: :created, location: @item_history }
      else
        format.html { render action: 'new' }
        format.json { render json: @item_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_histories/1
  # PATCH/PUT /item_histories/1.json
  def update
    respond_to do |format|
      if @item_history.update(item_history_params)
        format.html { redirect_to @item_history, notice: 'Item history was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @item_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_histories/1
  # DELETE /item_histories/1.json
  def destroy
    @item_history.destroy
    respond_to do |format|
      format.html { redirect_to item_histories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_history
      @item_history = ItemHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_history_params
      params.require(:item_history).permit(:datetime, :status, :utilization, :remarks)
    end
end
