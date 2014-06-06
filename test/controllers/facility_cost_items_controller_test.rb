require 'test_helper'

class FacilityCostItemsControllerTest < ActionController::TestCase
  setup do
    @facility_cost_item = facility_cost_items(:one)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = users(:userone)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facility_cost_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facility_cost_item" do
    assert_difference('FacilityCostItem.count') do
      post :create, facility_cost_item: { facility_id: @facility_cost_item.facility_id, name: @facility_cost_item.name }
    end

    assert_redirected_to facility_cost_item_path(assigns(:facility_cost_item))
  end

  test "should show facility_cost_item" do
    get :show, id: @facility_cost_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facility_cost_item
    assert_response :success
  end

  test "should update facility_cost_item" do
    patch :update, id: @facility_cost_item, facility_cost_item: { facility_id: @facility_cost_item.facility_id, name: @facility_cost_item.name }
    assert_redirected_to facility_cost_item_path(assigns(:facility_cost_item))
  end

  test "should destroy facility_cost_item" do
    assert_difference('FacilityCostItem.count', -1) do
      delete :destroy, id: @facility_cost_item
    end

    assert_redirected_to facility_cost_items_path
  end
end
