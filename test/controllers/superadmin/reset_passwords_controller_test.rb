require "test_helper"

class Superadmin::ResetPasswordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get superadmin_reset_passwords_index_url
    assert_response :success
  end
end
