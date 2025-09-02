require "test_helper"

class Master::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get master_users_index_url
    assert_response :success
  end
end
