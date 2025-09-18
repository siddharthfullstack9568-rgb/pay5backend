require "test_helper"

class Superadmin::ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get superadmin_reports_index_url
    assert_response :success
  end
end
