require 'minitest/autorun'
require './user'
require 'bcrypt'

include BCrypt

describe User do

  before do
    @password = "secret"
    @name = "Fred"
    @user = User.new @name, @password, @password
  end
  it "should be created with matching passwod confirmation" do
    a_user = User.new "Brooks", "same", "same"
    a_user.wont_be_nil 
  end
  it "has a name" do
    @user.name.must_equal @name
  end
  it "has an encrypted password" do
    @user.password.must_equal BCrypt::Engine.hash_secret(@password, @user.password)
  end
end
