require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "emails must be present" do
    user = User.first
    user.email = nil

    refute user.save
    assert user.errors[:email].present?
  end

  test "users must have a password" do
    user = users(:brit)
    user.password = nil

    refute user.save
    assert user.errors[:password].present?
  end

  test "users with an email and password can be saved" do
    user = User.new(email: "foo@bar.com", password: "hunter2")

    assert user.save
    assert user.errors.empty?
  end

  test "user emails must be unique" do
    user1 = users(:brit)
    user2 = users(:bob)

    user2.email = user1.email
    assert_equal user1.email, user2.email

    refute user2.save
    assert user2.errors[:email].find { |msg| msg.include?("taken") }
  end

  test "a user has many posts" do
    user = users(:brit)
    assert user.posts.count == 2
  end
end
