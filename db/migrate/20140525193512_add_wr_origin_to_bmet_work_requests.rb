class AddWrOriginToBmetWorkRequests < ActiveRecord::Migration
  def change
    add_column :bmet_work_requests, :wr_origin, :int
  end
end
