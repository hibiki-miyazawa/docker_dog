require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
   test "layout links non-admin" do
      @user = users(:lana)
      log_in_as(@user)
      get root_path
      assert_template 'static_pages/home'
      assert_select "a[href=?]", root_path, count: 2
      assert_select "a[href=?]", help_path
      assert_select "a[href=?]", about_path
      assert_select "a[href=?]", contact_path
      assert_select "a[href=?]", users_path, count: 0
      get contact_path
      assert_select "title", full_title("Contact")
   end

   test "layout links admin" do
      @user = users(:michael)
      @user1 = users(:archer)
      @user2 = users(:lana)
      @user3 = users(:lana)
      log_in_as(@user)
      get root_path
      assert_template 'static_pages/home'
      assert_select "a[href=?]", root_path, count: 2
      assert_select "a[href=?]", help_path
      assert_select "a[href=?]", about_path
      assert_select "a[href=?]", contact_path
      assert_select "a[href=?]", users_path
      get users_path
      assert_select "title", full_title("Index")
      assert_template 'users/index'
      assert_select "a[href=?]", user_path(@user), text: @user.name
      assert_select "a[href=?]", user_path(@user1), text: @user1.name
      assert_select "a[href=?]", user_path(@user2), text: @user2.name
      assert_select "a[href=?]", user_path(@user3), text: @user3.name
   end
end
