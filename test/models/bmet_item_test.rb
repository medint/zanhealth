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
		status_string_hash = ['Active','Inactive','Retired']
      	conditions_string_hash = ['Poor','Fair','Good','Very Good']    
		testItems = BmetItem.includes({:bmet_model => :item_group}, {:department => :facility}).where("id=?", @bmet_items.id)
		csv_string = testItems.as_csv
		rows = CSV.parse(csv_string)
		expected_values = @bmet_items.attributes.dup
		expected_values.shift
		expected_values["department_name"] = Department.find(expected_values["department_id"]).name
		expected_values["category"] = BmetModel.find(expected_values["bmet_model_id"]).category
		expected_values["manufacturer_name"] = BmetModel.find(expected_values["bmet_model_id"]).manufacturer_name
		expected_values["model_name"] = BmetModel.find(expected_values["bmet_model_id"]).model_name
		expected_values["vendor_name"] = BmetModel.find(expected_values["bmet_model_id"]).vendor_name
		expected_values["item_group"] = BmetModel.find(expected_values["bmet_model_id"]).item_group.name
		expected_values["status"] = status_string_hash[expected_values["status"]]
		expected_values["condition"] = conditions_string_hash[expected_values["condition"]]
		expected_values.delete("bmet_model_id")
		expected_values.delete("department_id")	
		rows[0].each_with_index do |key,index|
			assert_equal expected_values[key].to_s, rows[1][index]

		end
	end

	test "should import file data" do
		StagingItem.destroy_all
		StagingModel.destroy_all
		BmetModel.destroy_all
		BmetItem.destroy_all
		testFile = Tempfile.new('testFile.csv')
		testFile.write('serial_number,year_manufactured,funding,date_received,warranty_expire,contract_expire,
			warranty_notes,service_agent,department_name,price,asset_id,location,model_name,manufacturer_name,
			vendor_name, status, condition, notes /n
			1,2014,100,20071119,20071119,20071119,Warr notes here,Serv agent here,MyString,1000,69,
			Nowhere,Transmoglifier,Alan,Home Depot,active,good,240V 50Hz model-no')
		BmetModel.stage_import(testFile, users(:userone).facility.id)
		BmetItem.stage_import(testFile, users(:userone).facility.id)

		assert_not_nil StagingItem.all
		assert_not_nil StagingModel.all

		BmetItem.import(users(:userone).facility.id)
		BmetModel.import(users(:userone).facility.id)

		assert_not_nil BmetItem.all
		assert_not_nil BmetModel.all

		assert_equal nil, StagingItem.all[0]
		assert_equal nil, StagingModel.all[0]

	end

	# test "should export then import then export again" do
	# 	testItems = BmetItem.includes(:bmet_model, {:department => :facility}).where("id=?", @bmet_items.id)
	# 	csv_string1 = testItems.as_csv
	# 	BmetItem.destroy_all
	# 	BmetModel.destroy_all

	# 	testFile = File.open('testFile.csv','w')
	# 	testFile.write(csv_string1.to_s)
	# 	testFile.close()

	# 	testFile = File.open('testFile.csv','r')
	# 	BmetModel.stage_import(testFile, users(:userone).facility.id)
	# 	BmetItem.stage_import(testFile, users(:userone).facility.id)

	# 	assert_not_equal 0, StagingItem.all.size
	# 	assert_not_equal 0, StagingModel.all.size

	# 	BmetModel.import(users(:userone).facility.id)
	# 	BmetItem.import(users(:userone).facility.id)

	# 	assert_not_equal 0, BmetModel.all.size
	# 	assert_not_equal 0, BmetItem.all.size

	# 	testItems2 = BmetItem.all
	# 	csv_string2 = testItems2.as_csv

	# 	rows1 = CSV.parse(csv_string1)
	# 	rows2 = CSV.parse(csv_string2)

	# 	index = 0
	# 	rows1[1].zip(rows2[1]).each do |cell1, cell2|
	# 		if rows1[0][index] == 'created_at' || rows1[0][index] == 'updated_at'
	# 		else
	# 			if cell1 != cell2
	# 				assert false
	# 			end
	# 		end
	# 		index+=1
	# 	end
	# 	assert true
	# 	testFile.close()
	# end

end
