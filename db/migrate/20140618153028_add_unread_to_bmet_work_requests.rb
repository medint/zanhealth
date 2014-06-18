class AddUnreadToBmetWorkRequests < ActiveRecord::Migration
  def change
  	add_column :bmet_work_requests, :unread, :boolean
  end
end
