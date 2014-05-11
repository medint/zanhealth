require 'test_helper'
Capybara.current_driver = :poltergeist

class FacilityWorkRequestPublicNewTest < ActionDispatch::IntegrationTest
  setup do  	
		
  end

  test "create new work request form" do
    visit '/facility_work_requests/1/public_new' 

		assert_equal '/facility_work_requests/1/public_new', current_path

    fill_in 'facility_work_request[requester]', :with => 'John'
    fill_in 'facility_work_request[department]', :with => 'John'
    fill_in 'facility_work_request[location]', :with => 'John'
    fill_in 'facility_work_request[phone]', :with => 'John'
    fill_in 'facility_work_request[email]', :with => 'John'
    fill_in 'facility_work_request[description]', :with => 'John'

    click_button 'Create'

    current_url = current_path.split('/') #facility_work_requests/public_show/:id
    assert_equal 'facility_work_requests', current_url[1]
    assert_equal 'public_show', current_url[2]    
  end
end


