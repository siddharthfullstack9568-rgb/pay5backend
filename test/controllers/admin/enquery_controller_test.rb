require "test_helper"

class Admin::EnqueryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_enquery_index_url
    assert_response :success
  end
end
