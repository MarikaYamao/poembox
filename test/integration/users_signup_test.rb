require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information name" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@example.com",
                                         password:              "foobar",
                                         password_confirmation: "foobar" } }
    end
    assert_template 'users/new'
  end

  test "invalid signup information email" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "user",
                                         email: "",
                                         password:              "foobar",
                                         password_confirmation: "foobar" } }
    end
    assert_template 'users/new'
  end

  test "invalid signup information password" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "user",
                                         email: "user@example.com",
                                         password:              "foobar",
                                         password_confirmation: "example" } }
    end
    assert_template 'users/new'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.nil?
  end


  # test "the truth" do
  #   assert true
  # end
end
