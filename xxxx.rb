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

describe "Session" do
  before do
    @name = "Carlos"
    @password = "1234"
    @user = User.new(name: @name, password: @password)
    @user.save
  end
  it "should have a token" do
    session = Session.new(user: @user)
    session.token.wont_be_nil
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
