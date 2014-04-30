require 'test_helper'

class FacilityPreventativeMaintenancesControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = createTestUser()
    sign_in user
    @facility_preventative_maintenance = facility_preventative_maintenances(:one)
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

    assert_redirected_to facility_preventative_maintenance_path(assigns(:facility_preventative_maintenance))
  end

  test "should show facility_preventative_maintenance" do
    get :show, id: @facility_preventative_maintenance
    assert_response :success
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
