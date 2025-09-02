require "test_helper"

class Superadmin::ServiceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get superadmin_service_index_url
    assert_response :success
  end
end
