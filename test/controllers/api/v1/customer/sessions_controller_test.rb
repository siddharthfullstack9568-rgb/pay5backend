require "test_helper"

class Api::V1::Customer::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get api_v1_customer_sessions_login_url
    assert_response :success
  end
end
