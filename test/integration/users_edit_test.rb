require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:alexandra)
  end

  test 'unsuccessful edit' do
    get edit_user_path(@user)
    patch user_path(@user), params: {
      user: { name: '', email: 'user@invalid', password: 'foo', password_confirmation: 'bar' }
    }

    assert_template 'users/edit'
    assert_select 'div#error_explanation'
    assert_select 'div.alert', text: 'The form contains 4 errors.'
  end

  test ' successful edit' do
    get edit_user_path(@user)
    name = 'Example User'
    email = 'user@example.com'
    patch user_path(@user), params: {
      user: { name: name, email: email, password: '', password_confirmation: '' }
    }

    assert_not flash.empty?
    assert_redirected_to @user

    @user.reload

    assert_equal @user.name, name
    assert_equal @user.email, email
  end
end
