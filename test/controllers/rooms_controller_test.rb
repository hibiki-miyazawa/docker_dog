require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should not create Room when not logged in" do
    assert_no_difference 'Room.count' do
      post rooms_path
    end
    assert_redirected_to login_url
  end

  test "should no create Entry when no logged in" do
    assert_no_difference 'Entry.count' do
      post rooms_path
    end
    assert_redirected_to login_url
  end
end
