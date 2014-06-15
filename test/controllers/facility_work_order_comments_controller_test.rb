require 'test_helper'

class FacilityWorkOrderCommentsControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = users(:userone)
    sign_in @user
    @facility_work_order_comment = facility_work_order_comments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facility_work_order_comments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facility_work_order_comment with unhidden work order" do
    assert_difference('FacilityWorkOrderComment.count') do
  	  @request.headers["HTTP_REFERER"] = "/facility_work_orders/unhidden/"+(@facility_work_order_comment.facility_work_order.id.to_s)
      post :create, facility_work_order_comment: { 
        comment_text: @facility_work_order_comment.comment_text,
        datetime_stamp: @facility_work_order_comment.datetime_stamp,
        facility_work_order_id: @facility_work_order_comment.facility_work_order_id
      }
    end

    assert_equal assigns(:facility_work_order_comment).user_id, @user.id
    assert_redirected_to "/facility_work_orders/unhidden/"+(@facility_work_order_comment.facility_work_order.id.to_s)
    assert_response  :redirect
  end
  
  test "should create facility_work_order_comment with hidden work order" do
    assert_difference('FacilityWorkOrderComment.count') do
  	  @request.headers["HTTP_REFERER"] = "/facility_work_orders/hidden/"+(@facility_work_order_comment.facility_work_order.id.to_s)
      post :create, facility_work_order_comment: { comment_text: @facility_work_order_comment.comment_text, datetime_stamp: @facility_work_order_comment.datetime_stamp, facility_work_order_id: @facility_work_order_comment.facility_work_order_id, user_id: @facility_work_order_comment.user_id }
    end

    assert_redirected_to "/facility_work_orders/hidden/"+(@facility_work_order_comment.facility_work_order.id.to_s)
    assert_response  :redirect
  end

  test "should create facility_work_order_comment with all work orders" do
    assert_difference('FacilityWorkOrderComment.count') do
  	  @request.headers["HTTP_REFERER"] = "/facility_work_orders/all/"+(@facility_work_order_comment.facility_work_order.id.to_s)
      post :create, facility_work_order_comment: { comment_text: @facility_work_order_comment.comment_text, datetime_stamp: @facility_work_order_comment.datetime_stamp, facility_work_order_id: @facility_work_order_comment.facility_work_order_id, user_id: @facility_work_order_comment.user_id }
    end

    assert_redirected_to "/facility_work_orders/all/"+(@facility_work_order_comment.facility_work_order.id.to_s)
    assert_response  :redirect
  end

  test "should show facility_work_order_comment" do
    get :show, id: @facility_work_order_comment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facility_work_order_comment
    assert_response :success
  end

  test "should update facility_work_order_comment" do
    patch :update, id: @facility_work_order_comment, facility_work_order_comment: { comment_text: @facility_work_order_comment.comment_text, datetime_stamp: @facility_work_order_comment.datetime_stamp, facility_work_order_id: @facility_work_order_comment.facility_work_order_id, user_id: @facility_work_order_comment.user_id }
    assert_redirected_to @facility_work_order_comment.facility_work_order
  end

  test "should destroy facility_work_order_comment" do
    @request.headers["HTTP_REFERER"] = "/facility_work_orders/unhidden/"+(@facility_work_order_comment.facility_work_order.id.to_s)
    assert_difference('FacilityWorkOrderComment.count', -1) do
      delete :destroy, id: @facility_work_order_comment
    end

    assert_redirected_to "/facility_work_orders/unhidden/"+(@facility_work_order_comment.facility_work_order.id.to_s)
  end
end