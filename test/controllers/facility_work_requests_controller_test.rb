require 'test_helper'

class FacilityWorkRequestsControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = users(:userone)
    sign_in @user
    @facility_work_request = facility_work_requests(:one)
    @facility_work_request_diff_facility = facility_work_requests(:two)

  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facility_work_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facility_work_request" do
    assert_difference('FacilityWorkRequest.count') do
      post :create, facility_work_request: { department: @facility_work_request.department, description: @facility_work_request.description, email: @facility_work_request.email, location: @facility_work_request.location, phone: @facility_work_request.phone, requester: @facility_work_request.requester }
    end
    assert_equal(@user.facility_id,assigns["facility_work_request"].facility_id)

    assert_redirected_to "/facility_work_requests/unhidden/"+(assigns["facility_work_request"].id).to_s
    assert_response :redirect
  end

  test "should show facility_work_request" do
    get :show, id: @facility_work_request
    assert_response :success
    get :show, id: @facility_work_request_diff_facility
    assert_response :redirect #should redirect to 404
  end

  test "should get edit" do
    get :edit, id: @facility_work_request
    assert_response :success
  end

  test "should update facility_work_request" do
  	@request.headers["HTTP_REFERER"] = "/facility_work_requests/unhidden/"+(@facility_work_request.id.to_s)
    patch :update, id: @facility_work_request, facility_work_request: { department: @facility_work_request.department, description: @facility_work_request.description, email: @facility_work_request.email, location: @facility_work_request.location, phone: @facility_work_request.phone, requester: @facility_work_request.requester }
    assert_redirected_to "/facility_work_requests/unhidden/"+(assigns["facility_work_request"].id).to_s 
    assert_response :redirect
  end

  test "should hide facility_work_requests" do
  	  @request.headers["HTTP_REFERER"] = "/facility_work_requests/unhidden/"+(@facility_work_request.id.to_s)
  	  put :hide, id:@facility_work_request, facility_work_request: {
	  	department: @facility_work_request.department,
	  	description: @facility_work_request.description,
	  	email: @facility_work_request.email,
	  	location: @facility_work_request.location,
	  	phone: @facility_work_request.phone,
	  	requester: @facility_work_request.requester }
	  assert_redirected_to "/facility_work_requests/unhidden"
	  assert_not_nil assigns["facility_work_request"].deleted_at
	  assert_response :redirect
  end

	test "should unhide facility_work_requests" do
  	  @request.headers["HTTP_REFERER"] = "/facility_work_requests/hidden/"+(@facility_work_request.id.to_s)
  	  put :hide, id:@facility_work_request, facility_work_request: {
	  	department: @facility_work_request.department,
	  	description: @facility_work_request.description,
	  	email: @facility_work_request.email,
	  	location: @facility_work_request.location,
	  	phone: @facility_work_request.phone,
	  	requester: @facility_work_request.requester,
	  	deleted_at: @facility_work_request.created_at
	  }
	  assert_redirected_to "/facility_work_requests/hidden"
	  assert_not_equal(assigns["facility_work_request"].deleted_at, assigns["facility_work_request"].created_at)
	  assert_response :redirect
  end

  test "should destroy facility_work_request" do
    assert_difference('FacilityWorkRequest.count', -1) do
      delete :destroy, id: @facility_work_request
    end

    assert_redirected_to facility_work_requests_path
  end

  test "should search and return something" do
    @results = FacilityWorkRequest.search("Description1").records
    assert_response :success
    assert_not_equal @results, nil, flash[:notice]
  end

end
