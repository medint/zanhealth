require 'test_helper'

class ItemHistoriesControllerTest < ActionController::TestCase
  setup do
    @item_history = item_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item_history" do
    assert_difference('ItemHistory.count') do
      post :create, item_history: { datetime: @item_history.datetime, remarks: @item_history.remarks, status: @item_history.status, utilization: @item_history.utilization }
    end

    assert_redirected_to item_history_path(assigns(:item_history))
  end

  test "should show item_history" do
    get :show, id: @item_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item_history
    assert_response :success
  end

  test "should update item_history" do
    patch :update, id: @item_history, item_history: { datetime: @item_history.datetime, remarks: @item_history.remarks, status: @item_history.status, utilization: @item_history.utilization }
    assert_redirected_to item_history_path(assigns(:item_history))
  end

  test "should destroy item_history" do
    assert_difference('ItemHistory.count', -1) do
      delete :destroy, id: @item_history
    end

    assert_redirected_to item_histories_path
  end
end
