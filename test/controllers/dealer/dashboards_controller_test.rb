require "test_helper"

class Dealer::DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dealer_dashboards_index_url
    assert_response :success
  end
end
