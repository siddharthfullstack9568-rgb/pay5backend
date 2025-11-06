require "test_helper"

class Dealer::WalletsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dealer_wallets_index_url
    assert_response :success
  end
end
