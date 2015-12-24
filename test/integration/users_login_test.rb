require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:john)
    @user.password = "password"
  end

  test 'invalid login credentials' do
    get login_path
    assert_template 'sessions/new'
    post login_path, email: "", password: ""
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'valid login credentials' do
    get login_path
    assert_template 'sessions/new'
    post login_path, email: @user.email, password: @user.password
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', user_path(@user)
    assert_select 'a[href=?]', logout_path
  end
end
