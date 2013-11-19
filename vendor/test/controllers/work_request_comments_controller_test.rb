require 'test_helper'

class WorkRequestCommentsControllerTest < ActionController::TestCase
  setup do
    @work_request_comment = work_request_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:work_request_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create work_request_comment" do
    assert_difference('WorkRequestComment.count') do
      post :create, work_request_comment: { comment_text: @work_request_comment.comment_text, datetime_stamp: @work_request_comment.datetime_stamp }
    end

    assert_redirected_to work_request_comment_path(assigns(:work_request_comment))
  end

  test "should show work_request_comment" do
    get :show, id: @work_request_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @work_request_comment
    assert_response :success
  end

  test "should update work_request_comment" do
    patch :update, id: @work_request_comment, work_request_comment: { comment_text: @work_request_comment.comment_text, datetime_stamp: @work_request_comment.datetime_stamp }
    assert_redirected_to work_request_comment_path(assigns(:work_request_comment))
  end

  test "should destroy work_request_comment" do
    assert_difference('WorkRequestComment.count', -1) do
      delete :destroy, id: @work_request_comment
    end

    assert_redirected_to work_request_comments_path
  end
end
