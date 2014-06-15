require 'test_helper'

class BmetCostItemsControllerTest < ActionController::TestCase
  setup do
    @bmet_cost_item = bmet_cost_items(:one)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = users(:userone)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bmet_cost_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bmet_cost_item" do
    assert_difference('BmetCostItem.count') do
      post :create, bmet_cost_item: { facility_id: @bmet_cost_item.facility_id, name: @bmet_cost_item.name }
    end

    assert_redirected_to bmet_cost_item_path(assigns(:bmet_cost_item))
  end

  test "should show bmet_cost_item" do
    get :show, id: @bmet_cost_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bmet_cost_item
    assert_response :success
  end

  test "should update bmet_cost_item" do
    patch :update, id: @bmet_cost_item, bmet_cost_item: { facility_id: @bmet_cost_item.facility_id, name: @bmet_cost_item.name }
    assert_redirected_to bmet_cost_item_path(assigns(:bmet_cost_item))
  end

  test "should destroy bmet_cost_item" do
    assert_difference('BmetCostItem.count', -1) do
      delete :destroy, id: @bmet_cost_item
    end

    assert_redirected_to bmet_cost_items_path
  end
end
