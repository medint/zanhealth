class RemoveDateRequestedFromFacilityWorkOrder < ActiveRecord::Migration
  def change
    remove_column :facility_work_orders, :date_requested, :datetime
  end
end
