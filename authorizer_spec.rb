require 'minitest/autorun'
require './user'
require './authorizer'

describe "Authorization" do
  it "should check user is authorized" do
    user = User.new(role: "admin")
    required_role = "admin"
    Authorizer::is_authorized?(user, required_role).must_equal true
  end
  it "should check if user is not authorized" do
    user = User.new()
    required_role = "admin"
    Authorizer::is_authorized?(user, required_role).must_equal false
  end
  it "should add action" do
    action = {action: "list_users", role: "admin"}
    Authorizer.add_action(action)
    Authorizer.actions.include?(action).must_equal true
  end
end
