require 'minitest/autorun'
require './user'

def authenticate user, pass
  User.find_by_name(user)
end

describe "Authentication" do
  it "should authenticate a user" do
    User.new(name: "Carlos", password: "1234", password_confirmation: "1234").save
    token = authenticate("Carlos", "1234")
    token.wont_be_nil
  end
  it "should not authenticate with an invalid credentials" do
    token = authenticate("", "pass")
    token.must_be_nil
  end
end
