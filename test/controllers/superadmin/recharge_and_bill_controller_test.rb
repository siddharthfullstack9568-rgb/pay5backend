require "test_helper"

class Superadmin::RechargeAndBillControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get superadmin_recharge_and_bill_index_url
    assert_response :success
  end
end
