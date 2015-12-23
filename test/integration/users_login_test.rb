require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  test 'invalid login credentials' do
    get login_path
    assert_template 'sessions/new'
    post login_path, email: "", password: ""
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end
