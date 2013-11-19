class CreateWorkRequests < ActiveRecord::Migration
  def change
    create_table :work_requests do |t|
      t.datetime :date_requested
      t.datetime :date_expire
      t.datetime :date_completed
      t.integer :request_type
      t.integer :cost
      t.text :description
      t.integer :status
      t.integer :requester_id
      t.text :cause_description
      t.text :action_taken
      t.text :prevention_taken

      t.timestamps
    end
  end
end
