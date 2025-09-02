require "test_helper"

class Admin::Master::DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_master_dashboards_index_url
    assert_response :success
  end
end
