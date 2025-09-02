require "test_helper"

class Api::V1::Master::DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_master_dashboards_index_url
    assert_response :success
  end
end
