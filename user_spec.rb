require 'minitest/autorun'
require './user'
require './password_confirmation_exception'
require 'bcrypt'

include BCrypt

describe User do

  before do
    @password = "secret"
    @name = "Fred"
    @user = User.new name: @name, password: @password, password_confirmation: @password
  end
  it "should be created with matching password confirmation" do
    a_user = User.new name: "Brooks", password: "same", password_confirmation: "same"
    a_user.wont_be_nil 
  end
  it "should raise an exception if created with unmatching password confirmation" do
    err = ->{ User.new name: "Brooks", password: "same", password_confirmation: "different" }.must_raise PasswordConfirmationException
    err.message.must_match /Passwords do not match/
  end
  it "has a name" do
    @user.name.must_equal @name
  end
  it "has an encrypted password" do
    @user.password.must_equal BCrypt::Engine.hash_secret(@password, @user.password)
  end
  it "can be set a new password" do
    new_password = "new"
    @user.set_password password: new_password, password_confirmation: new_password
    @user.password.must_equal BCrypt::Engine.hash_secret(new_password, @user.password)
  end
  it "should raise an exception when setting a new password with unmatching password confirmation" do
    err = ->{ @user.set_password password: "same", password_confirmation: "different" }.must_raise PasswordConfirmationException
    err.message.must_match /Passwords do not match/
  end
end
