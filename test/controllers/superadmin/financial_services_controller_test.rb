require "test_helper"

class Superadmin::FinancialServicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get superadmin_financial_services_index_url
    assert_response :success
  end
end
