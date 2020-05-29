require 'test_helper'

class DogsEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @dog = dogs(:dog1)
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_dog_path(@dog)
    assert_template 'dogs/edit'
    patch dog_path(@dog), params: { dog:{ name: "kuro", gender: "male", breed: "chiwawa", hospital: "DEFhospital", salon: "defsalon", image_name: @image_name } }
    assert_redirected_to @dog
    assert_not flash.empty?
    @dog.reload
    assert_equal "kuro", @user.name
    assert_equal "male", @user.gender
    assert_equal "chiwawa", @user.breed
    assert_equal "DEFhospital", @user.hospital
    assert_equal "defsalon", @user.salon
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_dog_path(@dog)
    assert_template 'dogs/edit'
    patch dog_path(@dog), params: { dog:{ name: "", hospital: "", salon: "defsalon", image_name: @image_name } }
    assert_template 'dogs/edit'
    assert_select 'div.alert'
  end
end
