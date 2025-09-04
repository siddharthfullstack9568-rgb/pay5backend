require "test_helper"

class Superadmin::ServiceProdcutsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get superadmin_service_prodcuts_index_url
    assert_response :success
  end
end
