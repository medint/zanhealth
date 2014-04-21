class AddFacilitiesextraToBmetWorkOrder < ActiveRecord::Migration
  def change
    add_column :bmet_work_orders, :date_started, :datetime
    add_column :bmet_work_orders, :department_id, :integer
  end
end
