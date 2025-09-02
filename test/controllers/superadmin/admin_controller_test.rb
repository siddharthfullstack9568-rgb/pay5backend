require "test_helper"

class Superadmin::AdminControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get superadmin_admin_index_url
    assert_response :success
  end
end
