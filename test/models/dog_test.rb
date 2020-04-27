require 'test_helper'

class DogTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:michael)
    @dog = @user.dogs.build(name: "dog_one", gender: 1, birthday: "20171115", hospital: "ABC病院", salon: "abcサロン", image_name: "#{@user.id}.jpg")
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

  test "type should be at most 25 characters" do
    @dog.type = "a" * 26
    assert_not @dog.valid?
  end

  test "sex should be 0 or 1 or nil" do
    @dog.gender = "2"
    assert @dog.valid?
    @dog.gender = "3"
    assert_not @dog.valid?
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

  test "image name should be present" do
    @dog.image_name = nil
    assert_not @dog.valid?
  end

  #test "birthday should be only date" do
  #  @dog.birthday = "201900224"
  #  assert_not @dog.valid?
  #end
  
end
