class RenameWorkRequestIdToBmetWorkOrderIdInTexts < ActiveRecord::Migration
  def change
  	  rename_column :texts, :work_request_id, :bmet_work_order_id
  end
end
