require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "unsuccesful edit" do
    get edit_user_path(@user)
    patch user_path(@user), params: { user: { name: "",
                                          email: "@invalid",
                                          password: "esle",
                                          password_confirmation: "else" } }
    assert_template 'users/edit'
    assert_select "div.alert", "The form contains 4 errors."
  end
end
