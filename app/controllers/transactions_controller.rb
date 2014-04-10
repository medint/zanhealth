class TransactionsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @transactions = Transaction.all.to_a.select do |transaction|
      user.facility == transaction.department.facility
    end
  end
end
