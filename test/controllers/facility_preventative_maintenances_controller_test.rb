require 'test_helper'

class FacilityPreventativeMaintenancesControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = users(:userone)
    sign_in @user
    @facility_preventative_maintenance = facility_preventative_maintenances(:one)
    @facility_preventative_maintenance_diff_facility = facility_preventative_maintenances(:two)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:facility_preventative_maintenances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create facility_preventative_maintenance" do
    assert_difference('FacilityPreventativeMaintenance.count') do
      post :create, facility_preventative_maintenance: { 
        last_date_checked: @facility_preventative_maintenance.last_date_checked, 
        days: @facility_preventative_maintenance.days,
        months: @facility_preventative_maintenance.months,
        next_date: @facility_preventative_maintenance.next_date, 
    }
      
    end
    assert_equal(@user.id,assigns["facility_preventative_maintenance"].requester_id)
    assert_equal(@user.facility_id,assigns["facility_preventative_maintenance"].requester.facility_id)

    assert_redirected_to facility_preventative_maintenance_path(assigns(:facility_preventative_maintenance))
  end

  test "should show facility_preventative_maintenance" do
    get :show, id: @facility_preventative_maintenance.id
    assert_response :success
    get :show, id: @facility_preventative_maintenance_diff_facility
    assert_response :redirect #should redirect to 404
  end

  test "should update facility_preventative_maintenance" do
    patch :update, id: @facility_preventative_maintenance, facility_preventative_maintenance: { 
        last_date_checked: @facility_preventative_maintenance.last_date_checked, 
        days: @facility_preventative_maintenance.days,
        months: @facility_preventative_maintenance.months,
        next_date: @facility_preventative_maintenance.next_date,  
      }
    assert_redirected_to facility_preventative_maintenance_path(assigns(:facility_preventative_maintenance))
  end

  test "should destroy facility_preventative_maintenance" do
    assert_difference('FacilityPreventativeMaintenance.count', -1) do
      delete :destroy, id: @facility_preventative_maintenance
    end

    assert_redirected_to facility_preventative_maintenances_path
  end

  test "should search and return something" do
    @results = FacilityPreventativeMaintenance.search("Description1").records
    assert_response :success
    assert_not_equal @results, nil, flash[:notice]
  end

end
