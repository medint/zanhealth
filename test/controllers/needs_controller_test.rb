require 'test_helper'

class NeedsControllerTest < ActionController::TestCase
  setup do
    @need = needs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:needs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create need" do
    assert_difference('Need.count') do
      post :create, need: { date_requested: @need.date_requested, location_id: @need.location_id, model_id: @need.model_id, name: @need.name, quantity: @need.quantity, reason: @need.reason, remarks: @need.remarks, stage: @need.stage, urgency: @need.urgency, user_id: @need.user_id }
    end

    assert_redirected_to need_path(assigns(:need))
  end

  test "should show need" do
    get :show, id: @need
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @need
    assert_response :success
  end

  test "should update need" do
    patch :update, id: @need, need: { date_requested: @need.date_requested, location_id: @need.location_id, model_id: @need.model_id, name: @need.name, quantity: @need.quantity, reason: @need.reason, remarks: @need.remarks, stage: @need.stage, urgency: @need.urgency, user_id: @need.user_id }
    assert_redirected_to need_path(assigns(:need))
  end

  test "should destroy need" do
    assert_difference('Need.count', -1) do
      delete :destroy, id: @need
    end

    assert_redirected_to needs_path
  end
end
