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

end
