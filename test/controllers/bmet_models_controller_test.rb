require 'test_helper'

class BmetModelsControllerTest < ActionController::TestCase
  setup do
    @bmet_model = bmet_models(:one)
    user = createTestUser()
    sign_in user
    @bmet_item = bmet_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bmet_models)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bmet_model" do
    assert_difference('BmetModel.count') do
      post :create, bmet_model: { category: @bmet_model.category, manufacturer_name: @bmet_model.manufacturer_name, model_name: @bmet_model.model_name, vendor_name: @bmet_model.vendor_name }
    end

    assert_redirected_to bmet_model_path(assigns(:bmet_model))
  end

  test "should show bmet_model" do
    get :show, id: @bmet_model
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bmet_model
    assert_response :success
  end

  test "should update bmet_model" do
    patch :update, id: @bmet_model, bmet_model: { category: @bmet_model.category, manufacturer_name: @bmet_model.manufacturer_name, model_name: @bmet_model.model_name, vendor_name: @bmet_model.vendor_name }
    assert_redirected_to bmet_model_path(assigns(:bmet_model))
  end

  test "should destroy bmet_model" do
    assert_difference('BmetModel.count', -1) do
      delete :destroy, id: @bmet_model
    end

    assert_redirected_to bmet_models_path
  end
end
