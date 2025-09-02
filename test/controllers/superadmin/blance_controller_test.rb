require "test_helper"

class Superadmin::BlanceControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get superadmin_blance_index_url
    assert_response :success
  end
end
