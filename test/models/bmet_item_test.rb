require 'test_helper'

class BmetItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
	setup do
		@bmet_items = bmet_items(:one)
		users(:userone)
		departments(:one)
	end
  
  	
	test "should export to csv" do
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
		assert true
	end

	test "should import test data" do
		testFile = Tempfile.new('testFile.csv')
		testFile.write('serial_number,year_manufactured,funding,date_received,warranty_expire,contract_expire,
			warranty_notes,service_agent,department_name,price,asset_id,item_type,location,model_name,manufacturer_name,
			vendor_name /n
			1,2014,100,20071119,20071119,20071119,Warr notes here,Serv agent here,SampleDepartment,1000,69,Machine,
			Nowhere,Transmoglifier,Alan,Home Depot')
		Department.import(testFile, :userone)
		BmetModel.import(testFile, :userone)
		BmetItem.import(testFile, :userone)
		puts Department.all
		#assert_not_nil Department.find_by_name("SampleDepartment")
		#assert_not_nil BmetModel.find_by_model_name("Transmoglifier")
		assert_not_nil BmetItem.find_by_year_manufactured(2014)

	end

end
