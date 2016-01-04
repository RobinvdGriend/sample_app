require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:john)
    @other_user = users(:michael)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get :edit, id: @user
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "should redirect update when not logged in" do
    patch :update, id: @user, user: { name: @user.name, email: @user.email }
    assert_not flash.empty?
    assert_redirected_to login_path
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as @user
    get :edit, id: @other_user
    assert flash.empty?
    assert_redirected_to root_path
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as @user
    patch :update, id: @other_user, user: { name: @other_user.name, email: @other_user.email }
    assert flash.empty?
    assert_redirected_to root_path
  end

  test "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_path
  end
end
