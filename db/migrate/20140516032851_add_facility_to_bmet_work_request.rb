class AddFacilityToBmetWorkRequest < ActiveRecord::Migration
  def change
    add_reference :bmet_work_requests, :facility, index: true
  end
end
