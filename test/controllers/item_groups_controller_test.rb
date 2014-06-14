require 'test_helper'

class ItemGroupsControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = users(:userone)
    sign_in @user
    @item_group = item_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:item_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item_group" do
    assert_difference('ItemGroup.count') do
      post :create, item_group: { name: @item_group.name }
    end

    assert_redirected_to item_group_path(assigns(:item_group))
  end

  test "should show item_group" do
    get :show, id: @item_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item_group
    assert_response :success
  end

  test "should update item_group" do
    patch :update, id: @item_group, item_group: { name: @item_group.name }
    assert_redirected_to item_group_path(assigns(:item_group))
  end

  test "should destroy item_group" do
    assert_difference('ItemGroup.count', -1) do
      delete :destroy, id: @item_group
    end

    assert_redirected_to item_groups_path
  end
end
