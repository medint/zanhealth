require 'test_helper'

class FacilityWorkOrderUiTest < ActionDispatch::IntegrationTest
  
  	setup do
  		@user = users(:userone)
  	end

	test "login" do
    # capybara methods, actually fills in forms and submits them  as a user would
		user = createTestUser()
		visit '/users/sign_in'

		fill_in 'user_login', :with => @user.username
		fill_in 'user_password', :with => 'password'
		click_button 'Sign in'
		assert_equal '/facility_work_orders', current_path
	
	end

  test "login and browse site" do
    # rails methods
    # login via https
    https!
    get "/users/sign_in"
    assert_response :success

	@user = users(:userone)
 	post_via_redirect user_session_path, 'user[login]' => @user.username, 'user[password]' => 'password'
 
    assert_equal '/facility_work_orders', path
 
    # https!(false)
    #get "/posts/all"
    #assert_response :success
    #assert assigns(:products)

  end

  

end
