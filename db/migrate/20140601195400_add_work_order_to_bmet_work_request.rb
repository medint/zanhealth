class AddWorkOrderToBmetWorkRequest < ActiveRecord::Migration
  def change
    add_column :bmet_work_requests, :wo_convert_id, :integer
    add_column :bmet_work_requests, :converted_at, :datetime
  end
end
