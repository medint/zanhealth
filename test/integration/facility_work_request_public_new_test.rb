require 'test_helper'
Capybara.current_driver = :poltergeist

class FacilityWorkRequestNewTest < ActionDispatch::IntegrationTest
  setup do  	
		
  end

  test "create new work request form" do
      visit '/facility_work_requests/1/new' 

		assert_equal '/facility_work_requests/1/new', current_path

    click_button 'Create'
    # important note, if javascript not enabled, then will allow creation
    # unless backend validation is there.

  end
end
