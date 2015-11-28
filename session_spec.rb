require 'minitest/autorun'
require './user'
require './session'

describe "Session" do
  before do
    @name = "Carlos"
    @password = "1234"
    @user = User.create(name: @name, password: @password)
  end
  it "should have a token" do
    session = Session.new(user: @user)
    session.token.wont_be_nil
  end
  it "should have a token with size 40" do
    session = Session.new(user: @user)
    session.save
    session.token.size.must_equal 40
  end
  describe "is_expired" do
    it "should return false if session has not expired" do
      session = Session.new(user: @user)
      session.save
      session.is_expired.must_equal false
    end
    it "should return true if session has expired" do
      session = Session.new(user: @user, created_at: Time.now - Session::EXPIRE_TIMEOUT_SECONDS)
      session.is_expired.must_equal true
    end
  end
end
