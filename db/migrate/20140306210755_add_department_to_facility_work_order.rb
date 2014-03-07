class AddDepartmentToFacilityWorkOrder < ActiveRecord::Migration
  def change
    add_reference :facility_work_orders, :department, index: true
  end
end
