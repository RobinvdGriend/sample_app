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

  test 'valid login credentials and logout' do
    get login_path
    post login_path, email: @user.email, password: @user.password
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select 'a[href=?]', login_path, count: 0
    assert_select 'a[href=?]', user_path(@user)
    assert_select 'a[href=?]', logout_path

    # Simulate a user clicking logout
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_path

    # Simulate a user clicking logout a second time
    delete logout_path
    follow_redirect!
    assert_select 'a[href=?]', login_path 
    assert_select 'a[href=?]', user_path(@user), count: 0
    assert_select 'a[href=?]', logout_path, count: 0
  end

  test "user login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not cookies['remember_token'].nil?
  end

  test "user login without remembering" do
    log_in_as(@user, remember_me: '0')
    assert cookies['remember_token'].nil?
  end
end
