class CreateFacilityWorkRequests < ActiveRecord::Migration
  def change
    create_table :facility_work_requests do |t|
      t.text :requester
      t.text :department
      t.text :location
      t.text :phone
      t.text :email
      t.text :description

      t.timestamps
    end
  end
end
