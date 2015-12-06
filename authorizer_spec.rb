require 'minitest/autorun'
require './user'
require './authorizer'

describe "Authorization" do
  before(:all) do
    @action = :view_profile
    Authorizer.add_action({action: @action, role: "admin"})
  end
  it "should check if user is authorized to perform action" do
    user = User.new(role: "admin")
    Authorizer::is_authorized?(user, @action).must_equal true
  end
  it "should check if user is not authorized" do
    user = User.new()
    Authorizer::is_authorized?(user, @action).must_equal false
  end
  it "should add action" do
    action = {action: "list_users", role: "admin"}
    Authorizer.add_action(action)
    Authorizer.actions.include?(action).must_equal true
  end
end
