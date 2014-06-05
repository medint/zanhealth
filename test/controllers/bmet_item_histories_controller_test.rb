require 'test_helper'

class BmetItemHistoriesControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = users(:userone)
    sign_in @user
    @bmet_item_history = bmet_item_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bmet_item_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bmet_item_history" do
    assert_difference('BmetItemHistory.count') do
      post :create, bmet_item_history: 
      { 
        bmet_item_condition: @bmet_item_history.bmet_item_condition, 
        bmet_item_id: @bmet_item_history.bmet_item_id, 
        bmet_item_status: @bmet_item_history.bmet_item_status, 
        remarks: @bmet_item_history.remarks, 
        work_order_id: @bmet_item_history.work_order_id, 
        work_order_status: @bmet_item_history.work_order_status 
      }
    end
    puts (assigns(:bmet_item_history)).attributes
    assert_redirected_to (assigns(:bmet_item_history))
  end

  test "should show bmet_item_history" do
    get :show, id: @bmet_item_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bmet_item_history
    assert_response :success
  end

  test "should update bmet_item_history" do
    patch :update, id: @bmet_item_history, bmet_item_history: { bmet_item_condition: @bmet_item_history.bmet_item_condition, bmet_item_id: @bmet_item_history.bmet_item_id, bmet_item_status: @bmet_item_history.bmet_item_status, remarks: @bmet_item_history.remarks, work_order: @bmet_item_history.work_order, work_order_status: @bmet_item_history.work_order_status }
    assert_redirected_to bmet_item_history_path(assigns(:bmet_item_history))
  end

  test "should destroy bmet_item_history" do
    assert_difference('BmetItemHistory.count', -1) do
      delete :destroy, id: @bmet_item_history
    end

    assert_redirected_to bmet_item_histories_path
  end
end
