class RemoveColumnsFromWorkRequests < ActiveRecord::Migration
  def change
    remove_column :work_requests, :action_taken
    remove_column :work_requests, :prevention_taken
    remove_column :work_requests, :cause_description
  end
end
