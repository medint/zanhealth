require 'test_helper'

class BmetWorkRequestsControllerTest < ActionController::TestCase
  setup do
    @bmet_work_request = bmet_work_requests(:one)
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

    assert_redirected_to bmet_work_request_path(assigns(:bmet_work_request))
  end

  test "should show bmet_work_request" do
    get :show, id: @bmet_work_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bmet_work_request
    assert_response :success
  end

  test "should update bmet_work_request" do
    patch :update, id: @bmet_work_request, bmet_work_request: { department: @bmet_work_request.department, description: @bmet_work_request.description, email: @bmet_work_request.email, location: @bmet_work_request.location, phone: @bmet_work_request.phone, requester: @bmet_work_request.requester }
    assert_redirected_to bmet_work_request_path(assigns(:bmet_work_request))
  end

  test "should destroy bmet_work_request" do
    assert_difference('BmetWorkRequest.count', -1) do
      delete :destroy, id: @bmet_work_request
    end

    assert_redirected_to bmet_work_requests_path
  end
end
