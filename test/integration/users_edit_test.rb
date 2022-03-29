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

  test "successful edit" do
    get edit_user_path(@user)
    name = "New Name"
    email = "new@mail.com"
    patch user_path(@user), params: { user: { name: name,
                                          email: email,
                                          password: "",
                                          password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
