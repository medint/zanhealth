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
  
  	
	test "should export to csv" do
		testItems = BmetItem.includes(:bmet_model, {:department => :facility}).where("id=?", @bmet_items.id)
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
		assert true
	end

	# test "should import test data" do
	# 	# Department.destroy_all
	# 	# BmetModel.destroy_all
	# 	# BmetItem.destroy_all
	# 	# testFile = Tempfile.new('testFile.csv')
	# 	# testFile.write('serial_number,year_manufactured,funding,date_received,warranty_expire,contract_expire,
	# 	# 	warranty_notes,service_agent,department_name,price,asset_id,item_type,location,model_name,manufacturer_name,
	# 	# 	vendor_name /n
	# 	# 	1,2014,100,20071119,20071119,20071119,Warr notes here,Serv agent here,SampleDepartment,1000,69,Machine,
	# 	# 	Nowhere,Transmoglifier,Alan,Home Depot')
	# 	# Department.import(testFile, :userone)
	# 	# BmetModel.import(testFile, :userone)
	# 	# BmetItem.import(testFile, :userone)
	# 	# assert_not_nil Department.all
	# 	# assert_not_nil BmetModel.all
	# 	# assert_not_nil BmetItem.all
	# 	#LOL THIS WAS A COMPLETE WASTE OF TIME AND NOW I HAVE TO REWRITE THE TEST HAHAHAHAHAHAHAHA

	# end

end
