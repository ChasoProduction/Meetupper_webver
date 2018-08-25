require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:sample)
  end

  test "should get index" do
    get users_path
    assert_response :success
  end

  test "should get new" do
    get new_user_path
    assert_response :success
  end

  test "should get edit" do
    get edit_user_path(@user)
    assert_response :success
  end

  test "should get show" do
    get user_path(@user)
    assert_response :success
  end

  test 'should delete data' do
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
  end
end