class CreateFacilityWorkOrders < ActiveRecord::Migration
  def change
    create_table :facility_work_orders do |t|
      t.datetime :date_requested
      t.datetime :date_expire
      t.datetime :date_completed
      t.integer :request_type
      t.integer :item
      t.integer :cost
      t.text :description
      t.integer :status
      t.integer :owner_id
      t.integer :requester_id
      t.text :cause_description
      t.text :action_taken
      t.text :prevention_taken

      t.timestamps
    end
  end
end
