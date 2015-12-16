require 'minitest/autorun'
require './user'
require './session'

describe "Session" do
  before do
    @name = "Carlos"
    @password = "1234"
    @user = User.create(name: @name, password: @password)
  end
  after do
    User.delete_all
    Session.delete_all
  end
  it "should be only one session per user" do
    a_user = User.create(name: "some", password: "password")
    Session.create(user: a_user)
    Session.create(user: a_user)
    Session.where(user: a_user).size.must_equal 1
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
      session.is_expired?.must_equal false
    end
    it "should return true if session has expired" do
      session = Session.new(user: @user, created_at: Time.now - Session::EXPIRE_TIMEOUT_SECONDS)
      session.is_expired?.must_equal true
    end
  end
end
