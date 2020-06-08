require 'test_helper'
include ActionDispatch::TestProcess

class DogsEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @dog = dogs(:dog1)
  end

  test "successful edit" do
    @image_name = fixture_file_upload('test/fixtures/files/20200528140356.jpg', 'image/jpg')
    log_in_as(@user)
    get edit_dog_path(@dog)
    assert_template 'dogs/edit'
    patch dog_path(@dog), params: { dog:{ name: "kuro", gender: "male", breed: "chiwawa", hospital: "DEFhospital", salon: "defsalon", image_name: @image_name } }
    assert_redirected_to @dog
    follow_redirect!
    assert_not flash.empty?
    assert_select "img[src*='#{@image_name_url}']"
    @dog.reload
    assert_equal "kuro", @dog.name
    assert_equal "male", @dog.gender
    assert_equal "chiwawa", @dog.breed
    assert_equal "DEFhospital", @dog.hospital
    assert_equal "defsalon", @dog.salon
  end

  test "successful delete image" do
    @image_name = fixture_file_upload('test/fixtures/files/default.jpg', 'image/jpg')
    log_in_as(@user)
    get edit_dog_path(@dog)
    assert_template 'dogs/edit'
    patch dog_path(@dog), params: { dog:{ name: "kuro", gender: "male", breed: "chiwawa", hospital: "DEFhospital", salon: "defsalon", delete_image_name: "1" } }
    assert_redirected_to @dog
    follow_redirect!
    assert_not flash.empty?
    assert_select "img[src*='#{@image_name_url}']"
    @dog.reload
    assert_equal "kuro", @dog.name
    assert_equal "male", @dog.gender
    assert_equal "chiwawa", @dog.breed
    assert_equal "DEFhospital", @dog.hospital
    assert_equal "defsalon", @dog.salon
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_dog_path(@dog)
    assert_template 'dogs/edit'
    patch dog_path(@dog), params: { dog:{ name: "", hospital: "", salon: "defsalon" } }
    assert_template 'dogs/edit'
    assert_select 'div.alert'
  end
end
