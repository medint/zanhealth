class CreateFacilityLaborHours < ActiveRecord::Migration
  def change
    create_table :facility_labor_hours do |t|
      t.datetime :date_started
      t.integer :duration
      t.integer :technician_id
      t.integer :work_request_id

      t.timestamps
    end
  end
end
