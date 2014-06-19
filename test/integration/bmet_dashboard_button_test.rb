require 'test_helper'
Capybara.current_driver = :poltergeist

class BmetDashboardButtonTest < ActionDispatch::IntegrationTest
  setup do
  	@user = users(:userone)
		visit '/users/sign_in'

		fill_in 'user_login', :with => @user.username
		fill_in 'user_password', :with => 'password'
		click_button 'Sign in'
  end

  test "click the buttons" do
    visit '/bmet_dashboard' 

		assert_equal '/bmet_dashboard', current_path
    click_button 'Statuses'
    find('#chart_div')
		assert_equal '/bmet_dashboard/status', current_path
    visit '/bmet_dashboard'
    click_button 'Finances'
    find('#chart_div')
    assert_equal '/bmet_dashboard/wo_finances', current_path
    visit '/bmet_dashboard'
    click_button 'Labor Hours'
    find('#chart_div')
    assert_equal '/bmet_dashboard/labor_hours', current_path
    
  end
end