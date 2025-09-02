require "test_helper"

class Admin::RetailersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_retailers_index_url
    assert_response :success
  end
end
