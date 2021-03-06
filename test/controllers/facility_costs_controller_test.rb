require 'test_helper'

class FacilityCostsControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = users(:userone)
    sign_in @user
    @facility_cost = facility_costs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facility_costs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facility_cost with unhidden work request" do
    assert_difference('FacilityCost.count') do
  	  @request.headers["HTTP_REFERER"] = "/facility_work_orders/unhidden/"+(@facility_cost.facility_work_order.id.to_s)
      post :create, facility_cost: { cost: @facility_cost.cost, facility_work_order_id: @facility_cost.facility_work_order_id, facility_cost_item: @facility_cost.facility_cost_item, unit_quantity: @facility_cost.unit_quantity }
    end
    assert_redirected_to "/facility_work_orders/unhidden/"+(@facility_cost.facility_work_order.id.to_s)
    assert_response :redirect
  end

  test "should create facility_cost with hidden work request" do
    assert_difference('FacilityCost.count') do
  	  @request.headers["HTTP_REFERER"] = "/facility_work_orders/hidden/"+(@facility_cost.facility_work_order.id.to_s)
      post :create, facility_cost: { cost: @facility_cost.cost, facility_work_order_id: @facility_cost.facility_work_order_id, facility_cost_item: @facility_cost.facility_cost_item, unit_quantity: @facility_cost.unit_quantity }
    end
    assert_redirected_to "/facility_work_orders/hidden/"+(@facility_cost.facility_work_order.id.to_s)
    assert_response :redirect
  end

  test "should create facility_cost with all work request" do
    assert_difference('FacilityCost.count') do
  	  @request.headers["HTTP_REFERER"] = "/facility_work_orders/all/"+(@facility_cost.facility_work_order.id.to_s)
      post :create, facility_cost: { cost: @facility_cost.cost, facility_work_order_id: @facility_cost.facility_work_order_id, facility_cost_item: @facility_cost.facility_cost_item, unit_quantity: @facility_cost.unit_quantity }
    end
    assert_redirected_to "/facility_work_orders/all/"+(@facility_cost.facility_work_order.id.to_s)
    assert_response :redirect
  end

  test "should show facility_cost" do
    get :show, id: @facility_cost
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facility_cost
    assert_response :success
  end

  test "should update facility_cost" do
    patch :update, id: @facility_cost, facility_cost: { cost: @facility_cost.cost, facility_work_order_id: @facility_cost.facility_work_order_id, facility_cost_item: @facility_cost.facility_cost_item, unit_quantity: @facility_cost.unit_quantity }
    assert_redirected_to facility_cost_path(assigns(:facility_cost))
  end

  test "should destroy facility_cost" do
    @request.headers["HTTP_REFERER"] = "/facility_work_orders/unhidden/"+(@facility_cost.facility_work_order.id.to_s)
    assert_difference('FacilityCost.count', -1) do
      delete :destroy, id: @facility_cost
    end

    assert_redirected_to "/facility_work_orders/unhidden/"+(@facility_cost.facility_work_order.id.to_s)
  end
end
