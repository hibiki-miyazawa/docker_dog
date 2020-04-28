require 'test_helper'

class DogsNewTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "dognew should redirect root with invalid" do
    get dogsnew_path
    assert_redirected_to login_path
  end

  test "invalid dog account" do
    get dogsnew_path
    assert_no_difference 'Dogs.count' do
      post dogsnew_path, params: { dog:{ name: "", gender: "オス", birthday: "", breed: "", hospital: "ABChospital", salon: "abcsalon", image_name: "dog.jpg" } }
    end
    assert_template 'dogs/new'
  end

  test "valid dog account" do
    get dogsnew_path
    assert_difference 'Dog.count', 1 do
      post dogsnew_path, params: { dog:{ name: "Example User", gender: "オス", birthday: "20191019", breed: "チワワ", hospital: "ABChospital", salon: "abcsalon", image_name: "dog.jpg" } }
    end
    follow_redirect!
    assert_template 'dogs/show'
    assert_not flash.empty?
  end
end
