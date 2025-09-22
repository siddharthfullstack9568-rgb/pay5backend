require "test_helper"

class Superadmin::CustomerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get superadmin_customer_index_url
    assert_response :success
  end
end
