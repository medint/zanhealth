class AddWorkRequestIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :bmet_work_order_id, :integer
  end
end
