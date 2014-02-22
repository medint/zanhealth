class RemoveWorkRequestIdFromItems < ActiveRecord::Migration
  def change
      remove_column :items, :work_request_id
  end
end
