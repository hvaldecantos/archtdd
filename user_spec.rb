require 'minitest/autorun'
require './user'

describe User do
  it "has a name" do
    user = User.new "Fred"
    user.name.must_equal "Fred"
  end
end
