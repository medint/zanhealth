require 'test_helper'

class FacilityWorkOrdersControllerTest < ActionController::TestCase
  setup do
  	@request.env["devise.mapping"] = Devise.mappings[:user]
  	@user = users(:userone)
  	sign_in @user
    @facility_work_order = facility_work_orders(:one)
    @facility_work_order_diff_facility = facility_work_orders(:five)
    FacilityLaborHour.create!(
			:date_started => "2014-02-22 02:05:52",
	    :duration => 1,
	   	:technician => @user,
	  	:facility_work_order => @facility_work_order
	)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facility_work_orders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facility_work_order" do
    assert_difference('FacilityWorkOrder.count') do
      post :create, facility_work_order: { date_started: @facility_work_order.date_started, 
      	  								   date_expire: @facility_work_order.date_expire,
      	  								   date_completed: @facility_work_order.date_completed, 
      	  								   request_type: @facility_work_order.request_type, 
      	  								   description: @facility_work_order.description, 
      	  								   status: @facility_work_order.status, 
      	  								   owner_id: @facility_work_order.owner_id,
      	  								   cause_description: @facility_work_order.cause_description, 
      	  								   action_taken: @facility_work_order.action_taken, 
      	  								   prevention_taken: @facility_work_order.prevention_taken,
                             department_id: @facility_work_order.department_id  }
    end
    assert_redirected_to "/facility_work_orders/unhidden/"+(assigns["facility_work_order"].id).to_s
    assert_response :redirect
    assert_equal(@user.facility_id,assigns["facility_work_order"].department.facility_id)
    assert_equal(@user.id,assigns["facility_work_order"].requester_id)

  end

  test "should show facility_work_order" do
  	get :show, id: @facility_work_order
    assert_response :success
    get :show, id: @facility_work_order_diff_facility
    assert_response :redirect #should redirect to 404
  end

  test "should update facility_work_order" do
  	@request.headers["HTTP_REFERER"] = "/facility_work_orders/unhidden/"+(@facility_work_order.id.to_s)
    patch :update, id: @facility_work_order, facility_work_order: { date_started: @facility_work_order.date_started, 
    																date_expire: @facility_work_order.date_expire, 
    																date_completed: @facility_work_order.date_completed,
    																request_type: @facility_work_order.request_type,
    															 	description: @facility_work_order.description,
    																status: @facility_work_order.status,
    																owner_id: @facility_work_order.owner_id,
    																requester_id: @facility_work_order.requester_id,
    																cause_description: @facility_work_order.cause_description,
    																action_taken: @facility_work_order.action_taken,
    																prevention_taken: @facility_work_order.prevention_taken }
    assert_redirected_to "/facility_work_orders/unhidden/"+(assigns["facility_work_order"].id).to_s
    assert_response :redirect
  end

	test "should hide facility_work_order" do
  	@request.headers["HTTP_REFERER"] = "/facility_work_orders/unhidden/"+(@facility_work_order.id.to_s)
    put :hide, id: @facility_work_order, facility_work_order: { date_started: @facility_work_order.date_started, 
    																date_expire: @facility_work_order.date_expire, 
    																date_completed: @facility_work_order.date_completed,
    																request_type: @facility_work_order.request_type,
    															 	description: @facility_work_order.description,
    																status: @facility_work_order.status,
    																owner_id: @facility_work_order.owner_id,
    																requester_id: @facility_work_order.requester_id,
    																cause_description: @facility_work_order.cause_description,
    																action_taken: @facility_work_order.action_taken,
    																prevention_taken: @facility_work_order.prevention_taken }
    assert_not_nil assigns["facility_work_order"].deleted_at
    assert_redirected_to "/facility_work_orders/unhidden"
    assert_response :redirect
  end

  test "should unhide facility_work_order" do
  	  @request.headers["HTTP_REFERER"] = "/facility_work_orders/hidden/"+(@facility_work_order.id.to_s)
  	  put :hide, id: @facility_work_order, facility_work_order: { date_started: @facility_work_order.date_started,
  	  	  														  date_expire: @facility_work_order.date_expire,
  	  	  														  date_completed: @facility_work_order.date_completed,
  	  	  														  request_type: @facility_work_order.request_type,
  	  	  														  description: @facility_work_order.description,
  	  	  														  status: @facility_work_order.status,
  	  	  														  owner_id: @facility_work_order.owner_id,
  	  	  														  requester_id: @facility_work_order.requester_id,
  	  	  														  cause_description: @facility_work_order.cause_description,
  	  	  														  action_taken: @facility_work_order.action_taken,
  	  	  														  prevention_taken: @facility_work_order.prevention_taken,
  	  	  														  deleted_at: @facility_work_order.date_started }
  	  assert_not_equal(assigns["facility_work_order"].deleted_at, assigns["facility_work_order"].date_started)
  	  assert_redirected_to "/facility_work_orders/hidden"
      assert_response :redirect
  end

  test "should destroy facility_work_order" do
    assert_difference('FacilityWorkOrder.count', -1) do
      delete :destroy, id: @facility_work_order
    end

    assert_redirected_to facility_work_orders_path
    assert_response :redirect
  end

  test "should search and return something" do
    @results = FacilityWorkOrder.search("Description1").records
    assert_response :success
    assert_not_equal @results, nil, flash[:notice]
  end

end
