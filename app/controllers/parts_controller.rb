class PartsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @parts = Part.all.to_a.select do |part|
      user.facility == part.department.facility
    end
  end
end
