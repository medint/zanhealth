class RemoveCostFromFacilityWorkOrder < ActiveRecord::Migration
  def change
    remove_column :facility_work_orders, :cost, :integer
  end
end
