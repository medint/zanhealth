class AddWorkRequestIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :work_request_id, :integer
  end
end
