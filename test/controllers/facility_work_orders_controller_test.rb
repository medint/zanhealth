require 'test_helper'

class FacilityWorkOrdersControllerTest < ActionController::TestCase
  setup do
  	@request.env["devise.mapping"] = Devise.mappings[:user]
  	user = createTestUser()
  	sign_in user
    @facility_work_order = facility_work_orders(:one)
    FacilityLaborHour.create!(
			:date_started => "2014-02-22 02:05:52",
	    :duration => 1,
	   	:technician => user,
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
      	  								   requester_id: @facility_work_order.requester_id, 
      	  								   cause_description: @facility_work_order.cause_description, 
      	  								   action_taken: @facility_work_order.action_taken, 
      	  								   prevention_taken: @facility_work_order.prevention_taken  }
    end
    assert_redirected_to facility_work_order_path(assigns(:facility_work_order))
  end

  test "should show facility_work_order" do
  	get :show, id: @facility_work_order
    assert_response :success
  end

  test "should update facility_work_order" do
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
    assert_redirected_to facility_work_order_path(assigns(:facility_work_order))
  end

  test "should destroy facility_work_order" do
    assert_difference('FacilityWorkOrder.count', -1) do
      delete :destroy, id: @facility_work_order
    end

    assert_redirected_to facility_work_orders_path
  end

  test "should search" do
    # get :search params["Description1"]
    # assert_redirected_to facility_work_orders(:one)
  end

end
