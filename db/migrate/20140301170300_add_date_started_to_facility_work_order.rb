class AddDateStartedToFacilityWorkOrder < ActiveRecord::Migration
  def change
    add_column :facility_work_orders, :date_started, :datetime
  end
end
