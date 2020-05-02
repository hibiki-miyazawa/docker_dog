require 'test_helper'
include ActionDispatch::TestProcess

class DogTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:michael)
    @image_name = fixture_file_upload('test/fixtures/files/20200428110207.jpg', "image/jpg")
    @dog = @user.dogs.build(name: "dog_one", gender: "male", birthday: 2017-11-15, hospital: "ABC病院", salon: "abcサロン", image_name: @image_name)
  end

  test "should be valid" do
    assert @dog.valid?
  end

  test "user id should be present" do
    @dog.user_id = nil
    assert_not @dog.valid?
  end

  test "name should be present" do
    @dog.name = " "
    assert_not @dog.valid?
  end

  test "name should be at most 50 characters" do
    @dog.name = "a" * 51
    assert_not @dog.valid?
  end

  test "breed should be at most 25 characters" do
    @dog.breed = "a" * 26
    assert_not @dog.valid?
  end

  test "gender should be allow nil" do
    @dog.gender = nil
    assert @dog.valid?
  end

  test "hospital should be present" do
    @dog.hospital = " "
    assert_not @dog.valid?
  end

  test "salon should be present" do
    @dog.salon = " "
    assert_not @dog.valid?
  end

  #test "birthday should be only date" do
  #  @dog.birthday = "201900224"
  #  assert_not @dog.valid?
  #end
  
end
