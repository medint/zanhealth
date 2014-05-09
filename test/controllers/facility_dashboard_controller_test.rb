require 'test_helper'

class FacilityDashboardControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    # user = createTestUser()
    @user = users(:userdboard)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get status" do
    get(:status, {"dates"=>{"start_date(1i)"=>"2012", "start_date(2i)"=>"5", "start_date(3i)"=>"5", "end_date(1i)"=>"2019", "end_date(2i)"=>"5", "end_date(3i)"=>"5"}})
    assert_response :success
    assert_equal(2,assigns["work_orders_json"][1]["work_orders"].size)
    assert_equal(2,assigns["work_orders_json"][1]["num_work_orders"])
  end

  test "should get statusAjax" do
    get(:statusAjax, {"dates"=>{"start_date(1i)"=>"2012", "start_date(2i)"=>"5", "start_date(3i)"=>"5", "end_date(1i)"=>"2019", "end_date(2i)"=>"5", "end_date(3i)"=>"5"}})
    assert_response :success
    assert_equal(2,assigns["work_orders_json"]['rows'][5]['c'][2]['v'])
    assert_equal(1,assigns["work_orders_json"]['rows'][5]['c'][1]['v'])
    assert_equal(1,assigns["work_orders_json"]['rows'][4]['c'][2]['v'])
  end

  test "should get wofinances" do
    get(:wo_finances, {"dates"=>{"start_date(1i)"=>"2012", "start_date(2i)"=>"5", "start_date(3i)"=>"5", "end_date(1i)"=>"2019", "end_date(2i)"=>"5", "end_date(3i)"=>"5"}})
    assert_response :success
    assert_equal(2,assigns["work_orders_json"]["dashTesting"]["costs"].size)
    assert_equal(1050,assigns["work_orders_json"]["dashTesting"]["totalcost"])
  end

  test "should get laborhours" do
    get(:labor_hours, {"dates"=>{"start_date(1i)"=>"2012", "start_date(2i)"=>"5", "start_date(3i)"=>"5", "end_date(1i)"=>"2019", "end_date(2i)"=>"5", "end_date(3i)"=>"5"}})
    assert_response :success
    assert_equal(2,assigns["labor_hours_json"]["userd"]["costs"].size)
    assert_equal(35,assigns["labor_hours_json"]["userd"]["totalcost"])
  end

end
