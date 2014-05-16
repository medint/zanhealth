require 'test_helper'

class BmetWorkOrdersControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = users(:userone)
    sign_in @user
    @bmet_work_order = bmet_work_orders(:one)
    @bmet_work_order_diff_facility = bmet_work_orders(:two)    
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
      post :create, bmet_work_order: { 
        action_taken: @bmet_work_order.action_taken, 
        bmet_item_id: @bmet_work_order.bmet_item_id, 
        cause_description: @bmet_work_order.cause_description, 
        cost: @bmet_work_order.cost, 
        date_completed: @bmet_work_order.date_completed, 
        date_expire: @bmet_work_order.date_expire, 
        date_requested: @bmet_work_order.date_requested, 
        department_id: @bmet_work_order.department_id,
        description: @bmet_work_order.description, 
        owner_id: @bmet_work_order.owner_id, 
        prevention_taken: @bmet_work_order.prevention_taken, 
        request_type: @bmet_work_order.request_type, 
        requester_id: @bmet_work_order.requester_id, 
        status: @bmet_work_order.status
      }
    end
    assert_redirected_to bmet_work_order_path(assigns(:bmet_work_order))
    assert_response :redirect    
    assert_equal(@user.facility_id,assigns["bmet_work_order"].department.facility_id)
    assert_equal(@user.id,assigns["bmet_work_order"].requester_id)
  end

  test "should show bmet_work_order" do
    get :show, id: @bmet_work_order
    assert_response :success
    get :show, id: @bmet_work_order_diff_facility
    assert_response :redirect #should redirect to 404
  end

  test "should update bmet_work_order" do
    patch :update, id: @bmet_work_order, bmet_work_order: { 
      action_taken: @bmet_work_order.action_taken, 
      bmet_item_id: @bmet_work_order.bmet_item_id, 
      cause_description: @bmet_work_order.cause_description, 
      cost: @bmet_work_order.cost, 
      date_completed: @bmet_work_order.date_completed, 
      date_expire: @bmet_work_order.date_expire, 
      date_requested: @bmet_work_order.date_requested, 
      department: @bmet_work_order.department,
      description: @bmet_work_order.description, 
      owner_id: @bmet_work_order.owner_id, 
      prevention_taken: @bmet_work_order.prevention_taken, 
      request_type: @bmet_work_order.request_type, 
      requester_id: @bmet_work_order.requester_id, 
      status: @bmet_work_order.status }
    assert_redirected_to bmet_work_order_path(assigns(:bmet_work_order))
    assert_response :redirect
  end

  test "should destroy bmet_work_order" do
    assert_difference('BmetWorkOrder.count', -1) do
      delete :destroy, id: @bmet_work_order
    end

    assert_redirected_to bmet_work_orders_path
    assert_response :redirect
  end
end
