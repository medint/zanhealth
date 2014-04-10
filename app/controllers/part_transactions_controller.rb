class PartTransactionsController < ApplicationController
  before_action :set_part_transaction, only: [:show, :edit, :update, :destroy]

  # GET /part_transactions
  # GET /part_transactions.json
  def index
    @part_transactions = PartTransaction.all
  end

  # GET /part_transactions/1
  # GET /part_transactions/1.json
  def show
  end

  # GET /part_transactions/new
  def new
    @part_transaction = PartTransaction.new
  end

  # GET /part_transactions/1/edit
  def edit
  end

  # POST /part_transactions
  # POST /part_transactions.json
  def create
    @part_transaction = PartTransaction.new(part_transaction_params)

    respond_to do |format|
      if @part_transaction.save
        format.html { redirect_to @part_transaction, notice: 'Part transaction was successfully created.' }
        format.json { render action: 'show', status: :created, location: @part_transaction }
      else
        format.html { render action: 'new' }
        format.json { render json: @part_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /part_transactions/1
  # PATCH/PUT /part_transactions/1.json
  def update
    respond_to do |format|
      if @part_transaction.update(part_transaction_params)
        format.html { redirect_to @part_transaction, notice: 'Part transaction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @part_transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /part_transactions/1
  # DELETE /part_transactions/1.json
  def destroy
    @part_transaction.destroy
    respond_to do |format|
      format.html { redirect_to part_transactions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_part_transaction
      @part_transaction = PartTransaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def part_transaction_params
      params.require(:part_transaction).permit(:change_quantity, :date, :vendor, :price, :part_id)
    end
end
