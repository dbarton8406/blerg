require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "emails must be present" do
    user = User.new

    refute user.save
    assert user.errors[:email].present?
  end

  test "users must have a password" do
    user = User.new

    refute user.save
    assert user.errors[:password].present?
  end

  test "users with an email and password can be saved" do
    user = User.new(email: "foo@bar.com", password: "hunter2")

    assert user.save
    assert user.errors.empty?
  end

  test "user emails must be unique" do
    user1 = User.new(email: "foo@bar.com", password: "cookies")
    user2 = User.new(email: "foo@bar.com", password: "broked")

    assert_equal user1.email, user2.email
    assert user1.save
    refute user2.save
    assert user2.errors[:email].find { |msg| msg.include?("taken") }
  end
end
