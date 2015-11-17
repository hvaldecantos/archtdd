require 'minitest/autorun'
require './user'
require 'bcrypt'

include BCrypt

describe User do

  before do
    @password = "secret"
    @name = "Fred"
    @user = User.new @name, @password
  end
  it "has a name" do
    @user.name.must_equal @name
  end
  it "has an encrypted password" do
    @user.password.must_equal BCrypt::Engine.hash_secret(@password, @user.password)
  end
end
