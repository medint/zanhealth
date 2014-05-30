require 'test_helper'

class BmetPreventativeMaintenanceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
	setup do
		@bmetPM = bmet_preventative_maintenances(:one)
	end

	test "should export to csv" do
		test = BmetPreventativeMaintenance.all.where("id=?", @bmetPM.id)
		csv_string = test.as_csv
		rows = CSV.parse(csv_string)
		expected = @bmetPM.attributes.dup
		expected.shift
		expected["requester_id"] = User.find(expected["requester_id"]).name
		rows[1].zip(expected.values).each do |result, expect|
			if result.to_s != expect.to_s
				assert false
			end
		end
		assert true
	end
end
