require 'test_helper'

class BmetItemsControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = createTestUser()
    sign_in user
    @bmet_item = bmet_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bmet_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bmet_item" do
    assert_difference('BmetItem.count') do
      post :create, bmet_item: { asset_id: @bmet_item.asset_id, contract_expire: @bmet_item.contract_expire, date_received: @bmet_item.date_received, department_id: @bmet_item.department_id, funding: @bmet_item.funding, item_type: @bmet_item.item_type, location: @bmet_item.location, model_id: @bmet_item.model_id, price: @bmet_item.price, serial_number: @bmet_item.serial_number, service_agent: @bmet_item.service_agent, warranty_expire: @bmet_item.warranty_expire, warranty_notes: @bmet_item.warranty_notes, year_manufactured: @bmet_item.year_manufactured }
    end

    assert_redirected_to bmet_item_path(assigns(:bmet_item))
  end

  test "should show bmet_item" do
    get :show, id: @bmet_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bmet_item
    assert_response :success
  end

  test "should update bmet_item" do
    patch :update, id: @bmet_item, bmet_item: { asset_id: @bmet_item.asset_id, contract_expire: @bmet_item.contract_expire, date_received: @bmet_item.date_received, department_id: @bmet_item.department_id, funding: @bmet_item.funding, item_type: @bmet_item.item_type, location: @bmet_item.location, model_id: @bmet_item.model_id, price: @bmet_item.price, serial_number: @bmet_item.serial_number, service_agent: @bmet_item.service_agent, warranty_expire: @bmet_item.warranty_expire, warranty_notes: @bmet_item.warranty_notes, year_manufactured: @bmet_item.year_manufactured }
    assert_redirected_to bmet_item_path(assigns(:bmet_item))
  end

  test "should destroy bmet_item" do
    assert_difference('BmetItem.count', -1) do
      delete :destroy, id: @bmet_item
    end

    assert_redirected_to bmet_items_path
  end
end
