class CreateStagingItems < ActiveRecord::Migration
  def change
    create_table :staging_items do |t|
	    t.string   :serial_number
	    t.integer  :year_manufactured
	    t.string   :funding
	    t.date     :date_received
	    t.date     :warranty_expire
	    t.date     :contract_expire
	    t.text     :warranty_notes
	    t.string   :service_agent
	    t.integer  :department_name
	    t.decimal  :price
	    t.string   :asset_id
	    t.string   :item_type
	    t.string   :location
	    t.string   :model_name
	    t.string   :manufacturer_name
	    t.string   :vendor_name
	    t.integer  :status
	    t.integer  :condition
    end
  end
end
