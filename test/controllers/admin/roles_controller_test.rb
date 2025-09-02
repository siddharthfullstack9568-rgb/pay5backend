require "test_helper"

class Admin::RolesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_roles_index_url
    assert_response :success
  end
end
