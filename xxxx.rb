require 'minitest/autorun'
require './user'

def authenticate user, pass
  user = User.find_by_name(user)
  return false if user == nil
  user.password == BCrypt::Engine.hash_secret(pass, user.password)
end

describe "Authentication" do
  it "should authenticate a user" do
    User.new(name: "Carlos", password: "1234", password_confirmation: "1234").save
    authenticate("Carlos", "1234").must_equal true
  end
  it "should not authenticate with an invalid user" do
    authenticate("invalid", "pass").must_equal false
  end
  it "should not authenticate with a wrong password" do
    User.new(name: "Carlos", password: "1234", password_confirmation: "1234").save
    authenticate("Carlos", "pass").must_equal false
  end
end
