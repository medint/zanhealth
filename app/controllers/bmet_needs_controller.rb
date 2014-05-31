class BmetNeedsController < ApplicationController
  load_and_authorize_resource
  before_action :set_need, only: [:show, :edit, :update, :destroy]

  # GET /needs
  # GET /needs.json
  def index
    @needs = BmetNeed.all
  end

  # GET /needs/1
  # GET /needs/1.json
  def show
  end

  # GET /needs/new
  def new
    @need = BmetNeed.new
  end

  # GET /needs/1/edit
  def edit
  end

  # POST /needs
  # POST /needs.json
  def create
    @need = BmetNeed.new(need_params)

    respond_to do |format|
      if @need.save
        format.html { redirect_to @need, notice: 'BmetNeed was successfully created.' }
        format.json { render action: 'show', status: :created, location: @need }
      else
        format.html { render action: 'new' }
        format.json { render json: @need.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /needs/1
  # PATCH/PUT /needs/1.json
  def update
    respond_to do |format|
      if @need.update(need_params)
        format.html { redirect_to @need, notice: 'BmetNeed was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @need.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /needs/1
  # DELETE /needs/1.json
  def destroy
    @need.destroy
    respond_to do |format|
      format.html { redirect_to bmet_needs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_need
      @need = BmetNeed.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def need_params
      params.require(:bmet_need).permit(:name, :department_id, :bmet_model_id, :quantity, :urgency, :reason, :remarks, :stage, :date_requested, :user_id)
    end
end
