require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    @room = Room.create
  end

  

  test "invalid user test" do
    get room_path(@room)
    assert_redirected_to login_path
  end
end
