require 'test_helper'
Capybara.current_driver = :poltergeist

class FacilityDashboardButtonTest < ActionDispatch::IntegrationTest
  setup do
  	@user = users(:userone)
		visit '/users/sign_in'

		fill_in 'user_login', :with => @user.username
		fill_in 'user_password', :with => 'password'
		click_button 'Signfa in'
  end

  test "click the buttons" do
    visit '/facility_dashboard' 

		assert_equal '/facility_dashboard', current_path
    click_button 'Statuses'
    find('#chart_div')
		assert_equal '/facility_dashboard/status', current_path
    visit '/facility_dashboard'
    click_button 'Finances'
    find('#chart_div')
    assert_equal '/facility_dashboard/wo_finances', current_path
    visit '/facility_dashboard'
    click_button 'Labor Hours'
    find('#chart_div')
    assert_equal '/facility_dashboard/labor_hours', current_path
    
  end
end