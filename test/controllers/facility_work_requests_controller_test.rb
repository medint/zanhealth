require 'test_helper'

class FacilityWorkRequestsControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = User.create!(
      email: "c@c.com",
      password: "11111111",
      language: "english",
      facility_id: 1
    )
    sign_in @user
    @facility_work_request = facility_work_requests(:one)
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

    assert_redirected_to facility_work_request_path(assigns(:facility_work_request))
  end

  test "should show facility_work_request" do
    get :show, id: @facility_work_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facility_work_request
    assert_response :success
  end

  test "should update facility_work_request" do
    patch :update, id: @facility_work_request, facility_work_request: { department: @facility_work_request.department, description: @facility_work_request.description, email: @facility_work_request.email, location: @facility_work_request.location, phone: @facility_work_request.phone, requester: @facility_work_request.requester }
    assert_redirected_to facility_work_request_path(assigns(:facility_work_request))
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
