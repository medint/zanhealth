class RenameWorkOrderColumns < ActiveRecord::Migration
  def change
    rename_column :facility_work_order_comments, :work_request_id, :work_order_id
    rename_column :bmet_work_order_comments, :bmet_work_order_id, :work_order_id
  end
end
