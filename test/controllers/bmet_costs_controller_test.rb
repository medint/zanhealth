require 'test_helper'

class BmetCostsControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = createTestUser()
    sign_in user
    @bmet_cost = bmet_costs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bmet_costs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bmet_cost" do
    assert_difference('BmetCost.count') do
      post :create, bmet_cost: { bmet_work_order_id: @bmet_cost.bmet_work_order_id, cost: @bmet_cost.cost, created_at: @bmet_cost.created_at, name: @bmet_cost.name, unit_quantity: @bmet_cost.unit_quantity, updated_at: @bmet_cost.updated_at, work_request_id: @bmet_cost.work_request_id }
    end

    assert_redirected_to @bmet_cost.bmet_work_order
  end

  test "should show bmet_cost" do
    get :show, id: @bmet_cost
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bmet_cost
    assert_response :success
  end

  test "should update bmet_cost" do
    patch :update, id: @bmet_cost, bmet_cost: { bmet_work_order_id: @bmet_cost.bmet_work_order_id, cost: @bmet_cost.cost, created_at: @bmet_cost.created_at, name: @bmet_cost.name, unit_quantity: @bmet_cost.unit_quantity, updated_at: @bmet_cost.updated_at, work_request_id: @bmet_cost.work_request_id }
    assert_redirected_to @bmet_cost.bmet_work_order
  end

  test "should destroy bmet_cost" do
    assert_difference('BmetCost.count', -1) do
      delete :destroy, id: @bmet_cost
    end

    assert_redirected_to @bmet_cost.bmet_work_order
  end
end
