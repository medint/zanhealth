class LaborHours < ActiveRecord::Migration
  def change
  	create_table :labor_hours do |t|
      t.datetime :date_started
      t.integer :duration
      t.integer :technician_id
      t.integer :bmet_work_order_id

      t.timestamps
    end
  end
end
