require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @item = items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post :create, item: { category: @item.category, contract_expire: @item.contract_expire, date_received: @item.date_received, asset_id: @item.asset_id, funding: @item.funding, item_type: @item.item_type, department_id: @item.department_id, model_id: @item.model_id, price: @item.price, serial_number: @item.serial_number, service_agent: @item.service_agent, location: @item.location, warranty_expire: @item.warranty_expire, warranty_notes: @item.warranty_notes, year_manufactured: @item.year_manufactured }
    end

    assert_redirected_to item_path(assigns(:item))
  end

  test "should show item" do
    get :show, id: @item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item
    assert_response :success
  end

  test "should update item" do
    patch :update, id: @item, item: { category: @item.category, contract_expire: @item.contract_expire, date_received: @item.date_received, asset_id: @item.asset_id, funding: @item.funding, item_type: @item.item_type, department_id: @item.department_id, model_id: @item.model_id, price: @item.price, serial_number: @item.serial_number, service_agent: @item.service_agent, location: @item.location, warranty_expire: @item.warranty_expire, warranty_notes: @item.warranty_notes, year_manufactured: @item.year_manufactured }
    assert_redirected_to item_path(assigns(:item))
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete :destroy, id: @item
    end

    assert_redirected_to items_path
  end
end
