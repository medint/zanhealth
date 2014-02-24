class RenameWorkOrderToBmetWorkOrderInBmetWorkOrderComments < ActiveRecord::Migration
  def change
  	  rename_column :bmet_work_order_comments, :work_order_id, :bmet_work_order_id
  end
end
