require "test_helper"

class Admin::CollectMoneysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_collect_moneys_index_url
    assert_response :success
  end
end
