require 'test_helper'

class BmetItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
	setup do
		@bmet_items = bmet_items(:one)
		@bmet_item_two = bmet_items(:two)
		users(:userone)
		departments(:one)
	end

	test "should create a corresponding bmet item history" do 
		@bmet_item_two.update(:status => 1)
		@bmet_item_history =  BmetItemHistory.where(:bmet_item_id => @bmet_item_two.id).order('created_at DESC').first
		assert_equal @bmet_item_history.bmet_item_status, 1

		@bmet_item_two.update(:condition => 2)
		@bmet_item_history =  BmetItemHistory.where(:bmet_item_id => @bmet_item_two.id).order('created_at DESC').first
		assert_equal @bmet_item_history.bmet_item_condition, 2
	end
  
  	
	test "should export to csv and then import the same things and then export again" do
		testItems = BmetItem.includes(:bmet_model, {:department => :facility}).where("id=?", @bmet_items.id)
		#test = BmetWorkOrder.includes(:owner, :requester, :department).where("id=?", @bmet_work_orders.id)
		csv_string = testItems.as_csv
		rows = CSV.parse(csv_string)
		expected_values = @bmet_items.attributes.dup
		expected_values.shift
		expected_values["department"] = Department.find(expected_values["department_id"]).name
		expected_values["manufacturer_name"] = BmetModel.find(expected_values["bmet_model_id"]).manufacturer_name
		expected_values["model_name"] = BmetModel.find(expected_values["bmet_model_id"]).model_name
		expected_values["vendor_name"] = BmetModel.find(expected_values["bmet_model_id"]).vendor_name
		expected_values.shift
		expected_values.delete("department_id")
		rows[1].zip(expected_values.values).each do |result, expected|
			if result.to_s != expected.to_s
				assert false
			end
		end

		BmetItem.destroy_all

		#check the syntax at this line
		testFile = File.new("testFile", csv_string.to_s)

		Department.import(testFile, :userone)
		BmetModel.import(testFile, :userone)
		BmetItem.import(testFile, :userone)
		newTestItems = BmetItem.includes(:bmet_model, {:department => :facility}).where("id=?", @bmet_items.id)
		new_csv = newTestItems.as_csv
		rows = CSV.parse(new_csv)
		rows[1].zip(expected_values.values).each do |result, expected|
			if result.to_s != expected.to_s
				assert false
			end		
		end
		assert true
	end

end
