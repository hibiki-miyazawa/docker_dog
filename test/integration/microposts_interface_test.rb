require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  
  def setup
    @user = users(:michael)
  end

  test "micropost interface" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select 'input[type=file]'

    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: "" } }
    end
    assert_select 'div#error_explanation'

    content = "This is valid micropost."
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params: { micropost: {content: content} }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body

    assert_select 'span.fa-trash-alt'
    first_micropost = @user.microposts.first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end

    get user_path(@user)
    assert_select 'span.fa-trash-alt', count: 0
  end
end
