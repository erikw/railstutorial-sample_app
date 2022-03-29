require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "unsuccesful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    patch user_path(@user), params: { user: { name: "",
                                          email: "@invalid",
                                          password: "esle",
                                          password_confirmation: "else" } }
    assert_template 'users/edit'
    assert_select "div.alert", "The form contains 4 errors."
  end

  test "successful edit" do
    log_in_as(@user)
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

  test "successful edit with friendy forwarding" do
    get edit_user_path(@user)
    assert_equal edit_user_url(@user), session[:forwarding_url]
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    assert_nil session[:forwarding_url]
    name = "New Name"
    email = "new@mail.com"
    patch user_path(@user), params: { user: { name: name,
                                          email: email,
                                          password: "",
                                          password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    assert_nil session[:forwarding_url]
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
