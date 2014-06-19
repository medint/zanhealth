require 'test_helper'
Capybara.current_driver = :poltergeist

class FacilityWorkRequestNewTest < ActionDispatch::IntegrationTest
  setup do
  	@user = users(:userone)
		visit '/users/sign_in'

    fill_in 'user_login', :with => @user.username
    fill_in 'user_password', :with => 'password'

		click_button 'Sign in'

  end

  test "create new work request form" do
      visit '/facility_work_requests/new' 

		assert_equal '/facility_work_requests/new', current_path
      # page.save_screenshot('screenshot.png')
      click_button 'Create'
      # important note, if javascript not enabled, then will allow creation
      # unless backend validation is there.
		assert_equal '/facility_work_requests/new', current_path 

    fill_in 'facility_work_request[requester]', :with => 'Alan'
      click_button 'Create'
      assert_equal '/facility_work_requests/new', current_path      

    fill_in 'facility_work_request[department]', :with => 'CS'
      click_button 'Create'
      assert_equal '/facility_work_requests/new', current_path 

    fill_in 'facility_work_request[location]', :with => 'CIT'
      click_button 'Create'
      assert_equal '/facility_work_requests/new', current_path

    fill_in 'facility_work_request[phone]', :with => '123'
      click_button 'Create'
      assert_equal '/facility_work_requests/new', current_path

    fill_in 'facility_work_request[email]', :with => 'dont@read.this'
      click_button 'Create'
      assert_equal '/facility_work_requests/new', current_path

    fill_in 'facility_work_request[description]', :with => 'Write some integration tests pls'
      click_button 'Create'
      assert_not_equal '/facility_work_requests/new', current_path

  end
end
