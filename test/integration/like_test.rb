require 'test_helper'

class LikeTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other = users(:archer)
    log_in_as(@user)
  end

  test "iine paga" do
    get likes_path
    @likes = Like.where(id:@user.id)
    @likes.each do |like|
      assert_select "span.fas"
    end
  end 

  test "should iine a user the standard way" do
    assert_difference 'Like.count', 1 do
      post likes_path, params: { user_id: @user.id, micropost_id: 2 }
    end
  end

  test "should iine a user with Ajax" do
    assert_difference 'Like.count', 1 do
      post likes_path, xhr: true, params: { user_id: @user.id, micropost_id: 2 }
    end
  end

  test "should uniine a user the standard way" do
    @like = Like.create(user_id: @user.id, micropost_id: 2)
    assert_difference 'Like.count', -1 do
      delete like_path(@like)
    end
  end

  test "should uniine a user with Ajax" do
    @like = Like.create(user_id: @user.id, micropost_id: 2)
    assert_difference 'Like.count', -1 do
      delete like_path(@like), xhr: true
    end
  end

end
