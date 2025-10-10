require "test_helper"

class Api::V1::Customer::SetMpinsControllerTest < ActionDispatch::IntegrationTest
  test "should get set_mpin" do
    get api_v1_customer_set_mpins_set_mpin_url
    assert_response :success
  end
end
