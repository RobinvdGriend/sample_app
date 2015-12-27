require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:john)
  end

  test "unsuccesful edit" do
    log_in_as @user

    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path(@user), user: { name: "",
                                    email: "foo@invalid",
                                    password: "foo",
                                    password_confirmation: "bar" }
    assert_template "users/edit"
  end

  test "succesful edit" do
    log_in_as @user

    name = "Foo Bar"
    email = "foo@bar.com"

    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path(@user), user: { name: name,
                                    email: email,
                                    password: "",
                                    password_confirmation: "" }
    assert_not flash.empty?
    assert_redirected_to user_path(@user)
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end