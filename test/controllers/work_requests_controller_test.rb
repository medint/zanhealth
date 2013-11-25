require 'test_helper'

class WorkRequestsControllerTest < ActionController::TestCase
  setup do
    @work_request = work_requests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:work_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create work_request" do
    assert_difference('WorkRequest.count') do
      post :create, work_request: { action_taken: @work_request.action_taken, cause_description: @work_request.cause_description, cost: @work_request.cost, date_completed: @work_request.date_completed, date_expire: @work_request.date_expire, date_requested: @work_request.date_requested, description: @work_request.description, item: @work_request.item, owner_id: @work_request.owner_id, prevention_taken: @work_request.prevention_taken, request_type: @work_request.request_type, requester_id: @work_request.requester_id, status: @work_request.status }
    end

    assert_redirected_to work_request_path(assigns(:work_request))
  end

  test "should show work_request" do
    get :show, id: @work_request
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @work_request
    assert_response :success
  end

  test "should update work_request" do
    patch :update, id: @work_request, work_request: { action_taken: @work_request.action_taken, cause_description: @work_request.cause_description, cost: @work_request.cost, date_completed: @work_request.date_completed, date_expire: @work_request.date_expire, date_requested: @work_request.date_requested, description: @work_request.description, item: @work_request.item, owner_id: @work_request.owner_id, prevention_taken: @work_request.prevention_taken, request_type: @work_request.request_type, requester_id: @work_request.requester_id, status: @work_request.status }
    assert_redirected_to work_request_path(assigns(:work_request))
  end

  test "should destroy work_request" do
    assert_difference('WorkRequest.count', -1) do
      delete :destroy, id: @work_request
    end

    assert_redirected_to work_requests_path
  end
end
