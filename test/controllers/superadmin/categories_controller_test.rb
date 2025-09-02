require "test_helper"

class Superadmin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get superadmin_categories_index_url
    assert_response :success
  end
end
