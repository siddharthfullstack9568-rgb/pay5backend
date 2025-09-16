require "test_helper"

class Superadmin::PaymentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get superadmin_payments_index_url
    assert_response :success
  end
end
