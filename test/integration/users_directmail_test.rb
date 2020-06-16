require 'test_helper'

class UsersDirectmailTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
    @other_user = users(:lana)
    log_in_as(@user)
  end

  test "link Direct Mail" do
    get user_path(@other_user)
    assert_difference 'Room.count', 1, 'Entry.count', 2 do
      post rooms_path, params: { room: { user_id: @other_user.id }, entry: { user_id: @other_user.id } } 
    end
    @room = Room.find_by(id: 1)
    assert_redirected_to room_path(@room)
    follow_redirect!
    assert_template 'rooms/show'
    assert_select 'a[href=?]', user_path(@user), text: @user.name
    assert_select 'a[href=?]', user_path(@other_user), text: @other_user.name
    assert_difference 'Message.count', 1 do
      post messages_path, params: { message: { message: "Text.", room_id: 1 } }
    end
    assert_redirected_to room_path(@room)
    follow_redirect!
    assert_template 'rooms/show'
    assert_select 'strong', 'Text.'
    assert_no_difference 'Message.count' do
      post messages_path, params: { message: { message: "", room_id: 1 } }
    end
    assert_redirected_to room_path(@room)
    follow_redirect!
    assert_not flash.empty?
    get user_path(@other_user)
    #assert_select 'a[href=?]', room_path(@room), text: 'DM'
  end
end
