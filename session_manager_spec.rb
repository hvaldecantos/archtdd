require 'minitest/autorun'
require './user'
require './session'
require './session_manager'

describe "SessionManager" do

  describe "Authentication" do
    before do
      @name = "Carlos"
      @password = "1234"
      User.new(name: @name, password: @password).save
    end
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
  end

end