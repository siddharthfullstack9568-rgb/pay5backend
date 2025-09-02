require "test_helper"

class Superadmin::BanksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get superadmin_banks_index_url
    assert_response :success
  end
end
