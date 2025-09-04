require "test_helper"

class Admin::UserServicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_user_services_index_url
    assert_response :success
  end
end
