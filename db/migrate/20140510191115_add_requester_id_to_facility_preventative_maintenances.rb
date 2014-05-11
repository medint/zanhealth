class AddRequesterIdToFacilityPreventativeMaintenances < ActiveRecord::Migration
  def change
    add_column :facility_preventative_maintenances, :requester_id, :integer
  end
end
