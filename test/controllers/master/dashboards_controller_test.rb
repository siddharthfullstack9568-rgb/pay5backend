require "test_helper"

class Master::DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get master_dashboards_index_url
    assert_response :success
  end
end
