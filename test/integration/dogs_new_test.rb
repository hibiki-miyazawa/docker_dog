require './test/test_helper'
include ActionDispatch::TestProcess

class DogsNewTest < ActionDispatch::IntegrationTest
  include ApplicationHelper
  
  def setup
    @user = users(:michael)
    @image_name = fixture_file_upload('test/fixtures/files/20200428110207.jpg', 'image/jpg')
  end

  test "dognew should redirect root with invalid" do
    get dogsnew_path
    assert_redirected_to login_path
    log_in_as(@user)
    get dogsnew_path
    assert_template 'dogs/new'
  end

  test "invalid dog account" do
    log_in_as(@user)
    get dogsnew_path
    assert_no_difference 'Dog.count' do
      post dogsnew_path, params: { dog:{ name: "", gender: "male", breed: "", hospital: "ABChospital", salon: "abcsalon", image_name: @image_name } }
    end
    assert_template 'dogs/new'
  end

  test "valid dog account" do
    log_in_as(@user)
    get dogsnew_path
    assert_difference 'Dog.count', 1 do
      post dogsnew_path, params: { dog:{ name: "test1", gender: "male", birthday: "2019-10-19", breed: "チワワ", hospital: "ABChospital", salon: "abcsalon", image_name: @image_name } }
    end
    follow_redirect!
    assert_template 'dogs/show'
    assert_select 'h1', "test1"
    assert assigns(:dog).image_name
    assert_not flash.empty?

    get dogsnew_path
    assert_difference 'Dog.count', 1 do
      post dogsnew_path, params: { dog:{ name: "test2", gender: "male", birthday: "2019-10-19", breed: "チワワ", hospital: "ABChospital", salon: "abcsalon" } }
    end
    follow_redirect!
    assert_template 'dogs/show'
    assert_select 'h1', "test2"
    assert_select "img[src=?]", '/default.jpg'
    assert_not flash.empty?
  end
end
