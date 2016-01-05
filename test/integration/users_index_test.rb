require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:john)
    @non_admin = users(:michael)
  end

  test "index as admin including pagination" do
    log_in_as @admin
    get users_path
    assert_template "users/index"
    assert_select ".pagination"
    User.paginate(page: 1).each do |user|
      assert_select "a[href=?]", user_path(user), text: user.name
      unless user == @admin
        assert_select "a[href=?]", user_path(user), text: "delete"
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
    assert_redirected_to users_path
  end

  test "index as non-admin" do
    log_in_as @non_admin
    get users_path
    assert_select "a", text: "delete", count: 0
  end
end

