require "test_helper"

class Admin::DmtsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_dmts_index_url
    assert_response :success
  end
end
