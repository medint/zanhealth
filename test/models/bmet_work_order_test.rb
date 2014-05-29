require 'test_helper'

class BmetWorkOrderTest < ActiveSupport::TestCase
  setup do
		@bmet_work_orders = bmet_work_orders(:one)
		users(:userone)
		departments(:one)
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
