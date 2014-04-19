require 'test_helper'

class FacilityLaborHoursControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = createTestUser()
    sign_in user
    @facility_labor_hour = facility_labor_hours(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facility_labor_hours)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facility_labor_hour" do
    assert_difference('FacilityLaborHour.count') do
      post :create, facility_labor_hour: { created_at: @facility_labor_hour.created_at, date_started: @facility_labor_hour.date_started, duration: @facility_labor_hour.duration, facility_work_order_id: @facility_labor_hour.facility_work_order_id, technician_id: @facility_labor_hour.technician_id, updated_at: @facility_labor_hour.updated_at }
    end

    assert_redirected_to @facility_labor_hour.facility_work_order
  end

  test "should show facility_labor_hour" do
    get :show, id: @facility_labor_hour
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @facility_labor_hour
    assert_response :success
  end

  test "should update facility_labor_hour" do
    patch :update, id: @facility_labor_hour, facility_labor_hour: { created_at: @facility_labor_hour.created_at, date_started: @facility_labor_hour.date_started, duration: @facility_labor_hour.duration, facility_work_order_id: @facility_labor_hour.facility_work_order_id, technician_id: @facility_labor_hour.technician_id, updated_at: @facility_labor_hour.updated_at }
    assert_redirected_to @facility_labor_hour.facility_work_order
  end

  test "should destroy facility_labor_hour" do
    assert_difference('FacilityLaborHour.count', -1) do
      delete :destroy, id: @facility_labor_hour
    end

    assert_redirected_to @facility_labor_hour.facility_work_order
  end
end
