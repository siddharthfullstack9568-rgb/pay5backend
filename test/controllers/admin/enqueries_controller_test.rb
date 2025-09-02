require "test_helper"

class Admin::EnqueriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_enqueries_index_url
    assert_response :success
  end
end
