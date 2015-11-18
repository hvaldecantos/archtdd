require 'minitest/autorun'
require './user'

def authenticate user, pass
  user = User.find_by_name(user)
  return user if user == nil
  user.password == BCrypt::Engine.hash_secret(pass, user.password) ? user : nil
end

describe "Authentication" do
  it "should authenticate a user" do
    User.new(name: "Carlos", password: "1234", password_confirmation: "1234").save
    token = authenticate("Carlos", "1234")
    token.wont_be_nil
  end
  it "should not authenticate with an invalid user" do
    token = authenticate("invalid", "pass")
    token.must_be_nil
  end
  it "should not authenticate with a wrong password" do
    User.new(name: "Carlos", password: "1234", password_confirmation: "1234").save
    token = authenticate("Carlos", "pass")
    token.must_be_nil
  end
end
