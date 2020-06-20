require 'test_helper'

class UsersSearchTest < ActionDispatch::IntegrationTest
  
  include ApplicationHelper

  def setup
    @user = users(:michael)
    @other_user = users(:lana)
    log_in_as(@user)
  end

  test "search friends page" do
    get user_search_path(@user)
    assert_template 'users/search'
    assert_select "form select[name=prefecture_id]"
    get user_search_path(@user), params: { prefecture_id: 0 }
    assert_template 'users/search'
    assert_select 'a[href=?]', user_path(@user)
    assert_select 'a[href=?]', user_path(@other_user)
  end
end
