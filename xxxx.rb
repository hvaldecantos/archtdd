require 'minitest/autorun'
require './user'
require './session'

def authenticate user, pass
  user = User.find_by_name(user)
  return false if user == nil
  user.password == BCrypt::Engine.hash_secret(pass, user.password)
end

describe "Authentication" do
  before do
    @name = "Carlos"
    @password = "1234"
    User.new(name: @name, password: @password).save
  end
  it "should authenticate a user" do
    authenticate(@name, @password).must_equal true
  end
  it "should not authenticate with an invalid user" do
    authenticate("invalid", "pass").must_equal false
  end
  it "should not authenticate with a wrong password" do
    authenticate(@name, "wrong").must_equal false
  end
end
