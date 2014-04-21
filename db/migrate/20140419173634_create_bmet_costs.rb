class CreateBmetCosts < ActiveRecord::Migration
  def change
    create_table :bmet_costs do |t|
      t.string :name
      t.integer :unit_quantity
      t.integer :cost
      t.datetime :created_at
      t.datetime :updated_at
      t.integer :bmet_work_order_id
      t.integer :work_request_id

      t.timestamps
    end
  end
end
