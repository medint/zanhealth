require 'test_helper'
require 'rails/performance_test_help'

class WoIndexTest < ActionDispatch::PerformanceTest
  # Refer to the documentation for all available options
  # self.profile_options = { runs: 5, metrics: [:wall_time, :memory],
  #                          output: 'tmp/performance', formats: [:flat] }

  test "homepage" do
    get '/facility_work_orders?username=admin&encrypted_password=21232f297a57a5a743894a0e4a801fc3'
  end
end
