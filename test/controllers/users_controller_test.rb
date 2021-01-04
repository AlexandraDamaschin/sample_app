require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @base_title = 'Ruby on Rails Tutorial Sample App'
    @user = users(:alexandra)
  end

  test 'should get new' do
    get signup_path
    assert_response :success
  end

  test 'should get correct title' do
    get signup_path
    assert_response :success
    assert_select 'title', "Sign up | #{@base_title}"
  end

  test ' should redirect to edit when not logged in' do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test ' should redirect to update when not logged in' do
    patch user_path(@user), params: { user: { name: @user.name, email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end
end
