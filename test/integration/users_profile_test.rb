require 'test_helper'
include ActionDispatch::TestProcess

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
    @non_admin = users(:archer)
  end
  

  test "profile as non-admin including delete link when log in as admin user" do
    log_in_as(@user)
    get user_path(@non_admin)
    assert_template 'users/show'
    assert_select 'a[href=?]', user_path(@non_admin), text: 'delete user'
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "profile as non-admin including delete link when log in as non admin user" do
    log_in_as(@non_admin)
    get user_path(@non_admin)
    assert_template 'users/show'
    assert_select 'a[href=?]', user_path(@non_admin), text: 'delete user'
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "profile as admin not including delete link when log in as admin user" do
    log_in_as(@user)
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'a[href=?]', user_path(@user), text: 'delete user', count: 0
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_not flash.empty?
  end

  test "profile as admin not including delete link when log in as non admin user" do
    log_in_as(@non_admin)
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'a[href=?]', user_path(@user), text: 'delete user', count: 0
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
  end
  
    
end
