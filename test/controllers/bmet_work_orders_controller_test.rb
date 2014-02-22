require 'test_helper'

class BmetWorkOrdersControllerTest < ActionController::TestCase
  setup do
    @bmet_work_order = bmet_work_orders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bmet_work_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bmet_work_order" do
    assert_difference('BmetWorkOrder.count') do
      post :create, bmet_work_order: { action_taken: @bmet_work_order.action_taken, cause_description: @bmet_work_order.cause_description, cost: @bmet_work_order.cost, date_completed: @bmet_work_order.date_completed, date_expire: @bmet_work_order.date_expire, date_requested: @bmet_work_order.date_requested, description: @bmet_work_order.description, item: @bmet_work_order.item, owner_id: @bmet_work_order.owner_id, prevention_taken: @bmet_work_order.prevention_taken, request_type: @bmet_work_order.request_type, requester_id: @bmet_work_order.requester_id, status: @bmet_work_order.status }
    end

    assert_redirected_to bmet_work_order_path(assigns(:bmet_work_order))
  end

  test "should show bmet_work_order" do
    get :show, id: @bmet_work_order
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bmet_work_order
    assert_response :success
  end

  test "should update bmet_work_order" do
    patch :update, id: @bmet_work_order, bmet_work_order: { action_taken: @bmet_work_order.action_taken, cause_description: @bmet_work_order.cause_description, cost: @bmet_work_order.cost, date_completed: @bmet_work_order.date_completed, date_expire: @bmet_work_order.date_expire, date_requested: @bmet_work_order.date_requested, description: @bmet_work_order.description, item: @bmet_work_order.item, owner_id: @bmet_work_order.owner_id, prevention_taken: @bmet_work_order.prevention_taken, request_type: @bmet_work_order.request_type, requester_id: @bmet_work_order.requester_id, status: @bmet_work_order.status }
    assert_redirected_to bmet_work_order_path(assigns(:bmet_work_order))
  end

  test "should destroy bmet_work_order" do
    assert_difference('BmetWorkOrder.count', -1) do
      delete :destroy, id: @bmet_work_order
    end

    assert_redirected_to bmet_work_orders_path
  end
end
