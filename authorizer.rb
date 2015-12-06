class Authorizer
  @@actions = []
  def self.actions
    @@actions
  end
  def self.is_authorized? user, required_role
    user.has_role?(required_role)
  end
  def self.add_action action
  	@@actions << action
  end
end
