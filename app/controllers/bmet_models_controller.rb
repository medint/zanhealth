class BmetModelsController < ApplicationController
  load_and_authorize_resource
  layout 'layouts/bmet_app'
  before_action :set_bmet_model, only: [:show, :edit, :update, :destroy]
  before_action :set_bmet_models, only: [:show, :index, :new]
  before_action :set_item_groups, only: [:show, :new]

  # GET /bmet_models
  # GET /bmet_models.json
  def index
    
  end

  # GET /bmet_models/1
  # GET /bmet_models/1.json
  def show
  end

  # GET /bmet_models/new
  def new
    @bmet_model = BmetModel.new
  end

  # GET /bmet_models/1/edit
  def edit
  end

  # POST /bmet_models
  # POST /bmet_models.json
  def create
    @bmet_model = BmetModel.new(bmet_model_params)

    respond_to do |format|
      if @bmet_model.save
        format.html { redirect_to @bmet_model, notice: 'BmetModel was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bmet_model }
      else
        format.html { render action: 'new' }
        format.json { render json: @bmet_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bmet_models/1
  # PATCH/PUT /bmet_models/1.json
  def update
    respond_to do |format|
      if @bmet_model.update(bmet_model_params)
        format.html { redirect_to @bmet_model, notice: 'BmetModel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bmet_model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bmet_models/1
  # DELETE /bmet_models/1.json
  def destroy
    @bmet_model.destroy
    respond_to do |format|
      format.html { redirect_to bmet_models_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bmet_model
      @bmet_model = BmetModel.find_by_id(params[:id])

    end

    def set_bmet_models
      @bmet_models = BmetModel.where(:facility_id => current_user.facility_id).all
    end

    def set_item_groups
      @item_groups = ItemGroup.where(:facility_id => current_user.facility_id).all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bmet_model_params
      params.require(:bmet_model).permit(:model_name, :manufacturer_name, :vendor_name)
    end
end
