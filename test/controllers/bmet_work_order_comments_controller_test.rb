require 'test_helper'

class BmetWorkOrderCommentsControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = createTestUser()
    sign_in user
    @bmet_work_order_comment = bmet_work_order_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bmet_work_order_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bmet_work_order_comment" do
    assert_difference('BmetWorkOrderComment.count') do
      post :create, bmet_work_order_comment: { bmet_work_order_id: @bmet_work_order_comment.bmet_work_order_id, comment_text: @bmet_work_order_comment.comment_text, datetime_stamp: @bmet_work_order_comment.datetime_stamp, user_id: @bmet_work_order_comment.user_id }
    end

    assert_redirected_to @bmet_work_order_comment.bmet_work_order
  end

  test "should show bmet_work_order_comment" do
    get :show, id: @bmet_work_order_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bmet_work_order_comment
    assert_response :success
  end

  test "should update bmet_work_order_comment" do
    patch :update, id: @bmet_work_order_comment, bmet_work_order_comment: { bmet_work_order_id: @bmet_work_order_comment.bmet_work_order_id, comment_text: @bmet_work_order_comment.comment_text, datetime_stamp: @bmet_work_order_comment.datetime_stamp, user_id: @bmet_work_order_comment.user_id }
    assert_redirected_to @bmet_work_order_comment.bmet_work_order
  end

  test "should destroy bmet_work_order_comment" do
    assert_difference('BmetWorkOrderComment.count', -1) do
      delete :destroy, id: @bmet_work_order_comment
    end

    assert_redirected_to @bmet_work_order_comment.bmet_work_order
  end
end
