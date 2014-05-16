require 'test_helper'

class BmetPreventativeMaintenancesControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @user = users(:userone)
    sign_in @user
    @bmet_preventative_maintenance = bmet_preventative_maintenances(:one)
    @bmet_preventative_maintenance_diff_facility = bmet_preventative_maintenances(:two)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bmet_preventative_maintenances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bmet_preventative_maintenance" do
    assert_difference('BmetPreventativeMaintenance.count') do
      post :create, bmet_preventative_maintenance: {
       days: @bmet_preventative_maintenance.days, 
       description: @bmet_preventative_maintenance.description, 
       last_date_checked: @bmet_preventative_maintenance.last_date_checked, 
       months: @bmet_preventative_maintenance.months, 
       next_date: @bmet_preventative_maintenance.next_date, 
       weeks: @bmet_preventative_maintenance.weeks
     }
    end
    assert_equal(@user.id,assigns["bmet_preventative_maintenance"].requester_id)
    assert_equal(@user.facility_id,assigns["bmet_preventative_maintenance"].requester.facility_id)

    assert_redirected_to bmet_preventative_maintenance_path(assigns(:bmet_preventative_maintenance))
    assert_response :redirect
  end

  test "should fail to create bmet_preventative_maintenance" do
    @request.headers["HTTP_REFERER"] = "/bmet_preventative_maintenances/"+(@bmet_preventative_maintenance.id.to_s)
    assert_no_difference('BmetPreventativeMaintenance.count') do
      post :create, bmet_preventative_maintenance: { days: 0, description: "a", last_date_checked: nil, months: 0, next_date: nil, weeks: 0}
    end
  end

  test "should show bmet_preventative_maintenance" do
    get :show, id: @bmet_preventative_maintenance
    assert_response :success
    get :show, id: @bmet_preventative_maintenance_diff_facility
    assert_response :redirect #should redirect to 404
  end

  test "should update bmet_preventative_maintenance" do
    @request.headers["HTTP_REFERER"] = "/bmet_preventative_maintenances/"+(@bmet_preventative_maintenance.id.to_s)
    patch :update, id: @bmet_preventative_maintenance, bmet_preventative_maintenance: { 
      days: @bmet_preventative_maintenance.days, 
      description: @bmet_preventative_maintenance.description, 
      last_date_checked: @bmet_preventative_maintenance.last_date_checked, 
      months: @bmet_preventative_maintenance.months, 
      next_date: @bmet_preventative_maintenance.next_date, 
      weeks: @bmet_preventative_maintenance.weeks 
    }
    assert_redirected_to bmet_preventative_maintenance_path(assigns(:bmet_preventative_maintenance))
    assert_response :redirect
  end

  test "should destroy bmet_preventative_maintenance" do
    assert_difference('BmetPreventativeMaintenance.count', -1) do
      delete :destroy, id: @bmet_preventative_maintenance
    end

    assert_redirected_to bmet_preventative_maintenances_path
  end
end
