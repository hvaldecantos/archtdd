require './test_helper'

describe "SessionManager" do
  before do
    @name = "Carlos"
    @password = "1234"
    User.create(name: @name, password: @password)
  end
  after do
    User.delete_all
    Session.delete_all
  end
  describe "Authentication" do
    it "should authenticate a user" do
      SessionManager::authenticate(@name, @password).must_equal true
    end
    it "should not authenticate with an invalid user" do
      SessionManager::authenticate("invalid", "pass").must_equal false
    end
    it "should not authenticate with a wrong password" do
      SessionManager::authenticate(@name, "wrong").must_equal false
    end
    it "should return nil if authentication fails" do
      SessionManager.stub(:authenticate, false) do
        SessionManager::login(@name, "wrong password").must_equal nil
      end
    end
    it "should return a session if authentication passes" do
      SessionManager.stub(:authenticate, true) do
        SessionManager::login(@name, @password).must_be_instance_of Session
      end
    end
    it "should return a session with the same user that logged in" do
      SessionManager.stub(:authenticate, true) do
        user = User.create(name: "nuevo", password: "1234")
        session = SessionManager::login("nuevo", "1234")
        session.user.must_equal user
      end
    end
    it "should save session on db" do
      SessionManager.stub(:authenticate, true) do
        session = SessionManager::login(@name, @password)
        Session.find(session.id).wont_be_nil
      end
    end
    it "should delete session when logging out" do
      session = SessionManager::login(@name, @password)
      SessionManager::logout(session.token)
      Session.find_by_token(session.token).must_be_nil
    end
  end
  describe "Token" do
    it "should return false when token is invalid" do
      SessionManager::is_valid_token?("dsdfd").must_equal false
    end
    it "should return true when token is valid" do
      session = SessionManager::login(@name, @password)
      SessionManager::is_valid_token?(session.token).must_equal true
    end
    it "should return false when token is expired" do
      session = Session.new()
      session.stub(:is_expired?, true) do
        Session.stub(:find_by_token, session) do
          SessionManager::is_valid_token?(session.token).must_equal false
        end
      end
    end
  end
end
