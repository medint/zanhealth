require 'test_helper'
Capybara.current_driver = :poltergeist

class FacilityPreventativeMaintenancesNewTest < ActionDispatch::IntegrationTest
  setup do
  	@user = users(:userone)
		visit '/users/sign_in'

		fill_in 'user_login', :with => @user.username
		fill_in 'user_password', :with => 'password'
		click_button 'Sign in'
		
  end

  test "create new preventative maintenances form" do
      visit '/facility_preventative_maintenances/new' 

		assert_equal '/facility_preventative_maintenances/new', current_path
      # page.save_screenshot('screenshot.png')
      click_button 'Create'
      # important note, if javascript not enabled, then will allow creation
      # unless backend validation is there.
		assert_equal '/facility_preventative_maintenances/new', current_path

    fill_in 'facility_preventative_maintenance[description]', :with => 'Check to make sure CS team is alive'
    fill_in 'facility_preventative_maintenance[days]', :with => 'Wow this is not an integer'
      click_button 'Create'
      assert_equal '/facility_preventative_maintenances/new', current_path

    fill_in 'facility_preventative_maintenance[days]', :with => '69'
      click_button 'Create'
      assert_not_equal '/facility_preventative_maintenances/new', current_path
    
  end
end