require 'test_helper'

class BmetWorkRequestsControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]    
    @user = users(:userone)
    sign_in @user
    @bmet_work_request = bmet_work_requests(:one)
    @bmet_work_request_diff_facility = bmet_work_requests(:two)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bmet_work_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bmet_work_request" do
    assert_difference('BmetWorkRequest.count') do
      post :create, bmet_work_request: { department: @bmet_work_request.department, description: @bmet_work_request.description, email: @bmet_work_request.email, location: @bmet_work_request.location, phone: @bmet_work_request.phone, requester: @bmet_work_request.requester }
    end
    assert_equal(@user.facility_id,assigns["bmet_work_request"].facility_id)
    assert_redirected_to "/bmet_work_requests/unhidden/"+assigns["bmet_work_request"].id.to_s
    assert_response :redirect
  end

  test "should show bmet_work_request" do
    get :show, id: @bmet_work_request
    assert_response :success
    get :show, id: @bmet_work_request_diff_facility
    assert_response :redirect #should redirect to 404
  end

  test "should update bmet_work_request" do
  	  @request.headers["HTTP_REFERER"] = "/bmet_work_requests/unhidden/"+@bmet_work_request.id.to_s
    patch :update, id: @bmet_work_request, bmet_work_request: { department: @bmet_work_request.department, description: @bmet_work_request.description, email: @bmet_work_request.email, location: @bmet_work_request.location, phone: @bmet_work_request.phone, requester: @bmet_work_request.requester }
    assert_redirected_to "/bmet_work_requests/unhidden/"+assigns["bmet_work_request"].id.to_s
    assert_response :redirect
  end

  test "should hide bmet work request" do
  	@request.headers["HTTP_REFERER"] = "/bmet_work_requests/unhidden/"+@bmet_work_request.id.to_s
  	put :hide, id:@bmet_work_request, bmet_work_request:{ department:@bmet_work_request.department, 
  														 description:@bmet_work_request.description,
  														 email:@bmet_work_request.email, 
  														 location:@bmet_work_request.location,
  														 phone: @bmet_work_request.phone,
  														 requester:@bmet_work_request.requester }
  	assert_redirected_to "/bmet_work_requests/unhidden"
	assert_not_nil assigns["bmet_work_request"].deleted_at
	assert_response :redirect
  end

   test "should unhide bmet work request" do
  	@request.headers["HTTP_REFERER"] = "/bmet_work_requests/hidden/"+@bmet_work_request.id.to_s
  	put :hide, id:@bmet_work_request, bmet_work_request:{ department:@bmet_work_request.department, 
  														 description:@bmet_work_request.description,
  														 email:@bmet_work_request.email, 
  														 location:@bmet_work_request.location,
  														 phone: @bmet_work_request.phone,
  														 deleted_at:@bmet_work_request.created_at,
  														 requester:@bmet_work_request.requester }
  	assert_redirected_to "/bmet_work_requests/hidden"
  	assert_not_equal(assigns["bmet_work_request"].deleted_at, assigns["bmet_work_request"].created_at)
	assert_response :redirect
  end

  test "should destroy bmet_work_request" do
    @request.headers["HTTP_REFERER"] = "/bmet_work_requests/unhidden/"+@bmet_work_request.id.to_s
    assert_difference('BmetWorkRequest.count', -1) do
      delete :destroy, id: @bmet_work_request
    end

    assert_redirected_to bmet_work_requests_path+"/unhidden/"
  end
end
