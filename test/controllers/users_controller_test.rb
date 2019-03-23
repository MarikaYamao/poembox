require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "should get index" do
    get user_path(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_path(@user)
    assert_response :success
  end

  # test "should patch new" do
  #   patch user_path(@user)
  #   assert_response :success
  # end

  # test "should get create" do
  #   get users_create_url
  #   assert_response :success
  # end

end
