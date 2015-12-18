require './test_helper'
require 'bcrypt'

include BCrypt

describe User do

  before do
    @password = "secret"
    @name = "Fred"
    @user = User.new name: @name, password: @password
  end
  it "should be created with a name and a password" do
    a_user = User.new name: "Brooks", password: "same"
    a_user.wont_be_nil 
  end
  it "raises and exception is name is missing" do
    assert_raises ActiveRecord::RecordInvalid do
      User.create! password: "same"
    end
  end
  it "raises and exception is password is missing" do
    assert_raises ActiveRecord::RecordInvalid do
      User.create! name: "same"
    end
  end
  it "must raise an exception if name is not unique" do
    assert_raises ActiveRecord::RecordInvalid do
      u1 = User.new name: "Unique", password: "same"
      u2 = User.new name: "Unique", password: "same"
      u1.save!
      u2.save!
    end
  end
  it "has a name" do
    @user.name.must_equal @name
  end
  it "has an encrypted password" do
    @user.password.must_equal BCrypt::Engine.hash_secret(@password, @user.password)
  end
  it "can be set a new password" do
    new_password = "new"
    @user.set_password password: new_password
    @user.password.must_equal BCrypt::Engine.hash_secret(new_password, @user.password)
  end
  it "should have a role" do
    @user.role.wont_be_nil
  end
  it "should have a default role" do
    @user.has_role?("guest").must_equal true
  end
  it "should check it has a specific role" do
    @user.has_role?("admin").must_equal false
  end
end
