require "test_helper"

class Admin::Dealer::DashboardsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_dealer_dashboards_index_url
    assert_response :success
  end
end
