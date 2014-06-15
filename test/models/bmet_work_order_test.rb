require 'test_helper'

class BmetWorkOrderTest < ActiveSupport::TestCase
  setup do
		@bmet_work_orders = bmet_work_orders(:one)
		users(:userone)
		departments(:one)
	end
  
  	test "should create corresponding bmet item history when status of work order changed" do
  		@bmet_work_orders.update(:status => 2)
  		@bmet_item_history =  BmetItemHistory.where(:bmet_item_id => @bmet_work_orders.bmet_item_id, :work_order_id => @bmet_work_orders.id).order('created_at DESC').first
		assert_equal @bmet_item_history.work_order_status, 2
  	end

	test "should export to csv" do
		test = BmetWorkOrder.includes(:owner, :requester, :department).where("id=?", @bmet_work_orders.id)
		csv_string = test.as_csv
		rows = CSV.parse(csv_string)
		expected_values = @bmet_work_orders.attributes.dup
		expected_values.shift
		expected_values["status"] = @bmet_work_orders.set_status(expected_values["status"])
		expected_values["owner_id"] = User.find(expected_values["owner_id"]).name
		expected_values["requester_id"] = User.find(expected_values["requester_id"]).name
		expected_values["department_id"] = Department.find(expected_values["department_id"]).name
		rows[1].zip(expected_values.values).each do |result, expected|
			if result.to_s != expected.to_s
				assert false
			end
		end
		assert true
	end
end
