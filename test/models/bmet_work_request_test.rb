require 'test_helper'

class BmetWorkRequestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  	setup do
  		@bwr = bmet_work_requests(:one)
	end

	test "should export to csv" do
		test = BmetWorkRequest.where("id=?", @bwr.id)
		csv_string = test.as_csv
		rows = CSV.parse(csv_string)
		expected_values = @bwr.attributes.dup
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
