require 'test_helper'

class FacilityWorkRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  	setup do
  		@fwr = facility_work_requests(:one)
	end

	test "should export to csv" do
		test = FacilityWorkRequest.where("id=?", @fwr.id)
		csv_string = test.as_csv
		rows = CSV.parse(csv_string)
		expected_values = @fwr.attributes.dup
		expected_values.shift
		expected_values["facility_id"] = Facility.find(expected_values["facility_id"]).name
		rows[1].zip(expected_values.values).each do |res, exp|
			if res.to_s != exp.to_s
				assert false
			end
		end
		assert true
	end
end
