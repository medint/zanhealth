require 'test_helper'
Capybara.current_driver = :poltergeist

class BmetWorkRequestPublicNewTest < ActionDispatch::IntegrationTest
  setup do  	
		
  end

  test "create new work request form" do
    visit '/bmet_work_requests/1/public_new' 

		assert_equal '/bmet_work_requests/1/public_new', current_path

    fill_in 'bmet_work_request[requester]', :with => 'John'
    fill_in 'bmet_work_request[department]', :with => 'John'
    fill_in 'bmet_work_request[location]', :with => 'John'
    fill_in 'bmet_work_request[phone]', :with => 'John'
    fill_in 'bmet_work_request[email]', :with => 'John'
    fill_in 'bmet_work_request[description]', :with => 'John'

    click_button 'Create'

    current_url = current_path.split('/') #bmet_work_requests/public_show/:id
    assert_equal 'bmet_work_requests', current_url[1]
    assert_equal 'public_show', current_url[2]    
  end
end


