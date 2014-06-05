class AddWorkOrderDetailsToBmetItemHistory < ActiveRecord::Migration
  def change
    add_column :bmet_item_histories, :work_order_id, :integer
    add_column :bmet_item_histories, :bmet_item_condition, :integer
    add_column :bmet_item_histories, :work_order_status, :integer
    rename_column :bmet_item_histories, :status, :bmet_item_status
    remove_column :bmet_item_histories, :datetime
    remove_column :bmet_item_histories, :utilization
  end
end
