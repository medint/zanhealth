require 'test_helper'

class PartTransactionsControllerTest < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    user = createTestUser()
    sign_in user
    @part_transaction = part_transactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:part_transactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create part_transaction" do
    assert_difference('PartTransaction.count') do
      post :create, part_transaction: { change_quantity: @part_transaction.change_quantity, date: @part_transaction.date, part_id: @part_transaction.part_id, price: @part_transaction.price, vendor: @part_transaction.vendor }
    end

    assert_redirected_to part_transaction_path(assigns(:part_transaction))
  end

  test "should show part_transaction" do
    get :show, id: @part_transaction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @part_transaction
    assert_response :success
  end

  test "should update part_transaction" do
    patch :update, id: @part_transaction, part_transaction: { change_quantity: @part_transaction.change_quantity, date: @part_transaction.date, part_id: @part_transaction.part_id, price: @part_transaction.price, vendor: @part_transaction.vendor }
    assert_redirected_to part_transaction_path(assigns(:part_transaction))
  end

  test "should destroy part_transaction" do
    assert_difference('PartTransaction.count', -1) do
      delete :destroy, id: @part_transaction
    end

    assert_redirected_to part_transactions_path
  end
end
