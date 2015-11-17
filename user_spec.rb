require 'minitest/autorun'
require './user'

describe User do
  before do
    @user = User.new "Fred", "secret"
  end
  it "has a name" do
    @user.name.must_equal "Fred"
  end
  it "has a password" do
    @user.password.must_equal "secret"
  end
end
