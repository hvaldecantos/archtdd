require 'minitest/autorun'
require './user'

def authenticate user, pass
  ""
end

describe "Authentication" do
  it "should authenticate a user" do
    user = User.new name: "Carlos", password: "1234", password_confirmation: "1234"
    token = authenticate("Carlos", "1234")
    token.wont_be_nil
  end
end
