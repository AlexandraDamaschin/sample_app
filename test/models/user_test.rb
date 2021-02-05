# frozen_string_literal: true
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Example User', email: 'user@example.com',
                     password: 'foobar', password_confirmation: 'foobar')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = ''
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '     '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a' * 256
    assert_not @user.valid?
  end

  test 'email validation should accept valid addresses' do
    valid_addresses = %w[user@example.com USER@foo.COM  A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?
    end
  end

  test 'email validation should reject invalid addresses' do
    invalid_addresses = %w[user@exmaple,com user_at_foo.org user.name @example.foo @bar_baz.com foo @bar + baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?
    end
  end

  test 'email address should be unique' do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'email addresses should be saved as lower-case' do
    mixed_case_email = 'Foo@ExAMPle.CoM'
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test 'email should have a minimum length' do
    @user.password = @user.password_confirmation = 'a' * 5
    assert_not @user.valid?
  end

  test 'authenticated? should return false for a user with nil digest' do
    assert_not @user.authentificated?(:remember, '')
  end

  test 'associated micropost should be destroyed' do
    @user.save
    @user.microposts.create!(content: 'Content')
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test 'should follow and unfollow a user' do
    alexandra = users(:alexandra)
    archer = users(:archer)
    assert_not alexandra.following?(archer)

    alexandra.follow(archer)
    assert alexandra.following?(archer)
    assert archer.followers.include?(alexandra)

    alexandra.unfollow(archer)
    assert_not alexandra.following?(archer)

    # Users can't follow themselves.
    alexandra.follow(alexandra)
    assert_not alexandra.following?(alexandra)
  end

  test 'feed should have the right posts' do
    alexandra = users(:alexandra)
    archer = users(:archer)
    lana = users(:lana)
    # Posts from followed user
    lana.microposts.each do |post_following|
      assert alexandra.feed.include?(post_following)
    end

    alexandra.microposts.each do |post_self|
      assert alexandra.feed.include?(post_self)
      assert_equal alexandra.feed.distinct, alexandra.feed
    end

    archer.microposts.each do |post_self|
      assert archer.feed.include?(post_self)
    end

    archer.microposts.each do |post_unfollowed|
      assert_not alexandra.feed.include?(post_unfollowed)
    end
  end
end
