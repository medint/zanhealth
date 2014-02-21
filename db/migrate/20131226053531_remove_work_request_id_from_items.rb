class RemoveWorkRequestIdFromItems < ActiveRecord::Migration
  def change
      remove_column :items, :bmet_work_order_id
  end
end
