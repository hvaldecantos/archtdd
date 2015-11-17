require 'minitest/autorun'
require './user'
require 'bcrypt'

include BCrypt

describe User do

  before do
    @user = User.new "Fred", "secret"
  end
  it "has a name" do
    @user.name.must_equal "Fred"
  end
  it "has an encrypted password" do
    @user.password.must_equal BCrypt::Engine.hash_secret("secret", @user.password)
  end
end
