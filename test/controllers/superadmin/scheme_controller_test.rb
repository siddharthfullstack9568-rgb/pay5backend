require "test_helper"

class Superadmin::SchemeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get superadmin_scheme_index_url
    assert_response :success
  end
end
