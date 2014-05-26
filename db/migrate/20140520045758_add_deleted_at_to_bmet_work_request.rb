class AddDeletedAtToBmetWorkRequest < ActiveRecord::Migration
  def change
  	  add_column :bmet_work_requests, :deleted_at, :datetime
  	  add_index :bmet_work_requests, :deleted_at
  end
end
