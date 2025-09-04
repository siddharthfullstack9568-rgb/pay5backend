require "test_helper"

class Admin::RechargeAndBillsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_recharge_and_bills_index_url
    assert_response :success
  end
end
